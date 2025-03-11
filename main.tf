resource "aws_vpc_ipam" "this" {
  count = length(var.ipam)
  cascade = lookup(var.ipam[count.index], "cascade")
  description = lookup(var.ipam[count.index], "description")
  enable_private_gua = lookup(var.ipam[count.index], "enable_private_gua")
  tier = lookup(var.ipam[count.index], "tier")
  tags = merge(
    var.tags,
    lookup(var.ipam[count.index], "tags"),
    data.aws_default_tags.this.tags
  )

  operating_regions {
    region_name = data.aws_region.this.name
  }
}

resource "aws_vpc_ipam_pool" "this" {
  count = length(var.ipam) == 0 ? 0 : length(var.ipam_pool)
  address_family = lookup(var.ipam_pool[count.index], "address_family")
  ipam_scope_id  = element(aws_vpc_ipam.this.*.private_default_scope_id, lookup(var.ipam_pool[count.index], "ipam_scope_id"))
  allocation_default_netmask_length = lookup(var.ipam_pool[count.index], "allocation_default_netmask_length")
  allocation_max_netmask_length = lookup(var.ipam_pool[count.index], "allocation_max_netmask_length")
  allocation_min_netmask_length = lookup(var.ipam_pool[count.index], "allocation_min_netmask_length")
  allocation_resource_tags = lookup(var.ipam_pool[count.index], "allocation_resource_tags")
  auto_import = lookup(var.ipam_pool[count.index], "auto_import")
  aws_service = lookup(var.ipam_pool[count.index], "aws_service")
  cascade = lookup(var.ipam_pool[count.index], "cascade")
  description = lookup(var.ipam_pool[count.index], "description")
  locale = data.aws_region.this.name
  publicly_advertisable = lookup(var.ipam_pool[count.index], "publicly_advertisable")
  public_ip_source = lookup(var.ipam_pool[count.index], "public_ip_source")
  source_ipam_pool_id = element(aws_vpc_ipam.this.*.id, lookup(var.ipam_pool[count.index], "source_ipam_pool_id"))
  tags = merge(
    var.tags,
    lookup(var.ipam_pool[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}

resource "aws_vpc_ipam_pool_cidr" "this" {
  count = length(var.ipam_pool) == 0 ? 0 : length(var.ipam_pool_cidr)
  ipam_pool_id = element(aws_vpc_ipam_pool.this.*.id, lookup(var.ipam_pool_cidr[count.index], "ipam_pool_id"))
  cidr = lookup(var.ipam_pool_cidr[count.index], "cidr")
  netmask_length = lookup(var.ipam_pool_cidr[count.index], "netmask_length")
}

resource "aws_vpc" "vpc" {
  count                            = length(var.vpc)
  cidr_block                       = lookup(var.vpc[count.index], "cidr_block")
  instance_tenancy                 = lookup(var.vpc[count.index], "instance_tenancy")
  ipv4_ipam_pool_id = try(element(aws_vpc_ipam_pool.this.*.id, lookup(var.vpc[count.index], "ipv4_ipam_pool_id")))
  ipv4_netmask_length = lookup(var.vpc[count.index], "ipv4_netmask_length")
  ipv6_cidr_block = lookup(var.vpc[count.index], "ipv6_cidr_block")
  ipv6_cidr_block_network_border_group = lookup(var.vpc[count.index], "ipv6_cidr_block_network_border_group")
  ipv6_ipam_pool_id = try(element(aws_vpc_ipam_pool.this.*.id, lookup(var.vpc[count.index], "ipv6_ipam_pool_id")))
  ipv6_netmask_length = lookup(var.vpc[count.index], "ipv6_netmask_length")
  enable_dns_hostnames             = lookup(var.vpc[count.index], "enable_dns_hostnames", false)
  enable_dns_support               = lookup(var.vpc[count.index], "enable_dns_support", false)
  enable_network_address_usage_metrics = lookup(var.vpc[count.index], "enable_network_address_usage_metrics")
  assign_generated_ipv6_cidr_block = lookup(var.vpc[count.index], "assign_generated_ipv6_cidr_block", false)
  tags                             = var.tags
}