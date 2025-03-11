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
  tags                             = merge(
    var.tags,
    lookup(var.vpc[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}

resource "aws_internet_gateway" "this" {
  count = length(var.internet_gateway)
  vpc_id = element(aws_vpc.vpc.*.id, lookup(var.internet_gateway[count.index], "vpc_id"))
  tags = merge(
    var.tags,
    lookup(var.internet_gateway[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}

resource "aws_vpc_peering_connection" "this" {
  count = (length(var.vpc) || var.vpc_id != null) == 0 ? 0 : length(var.peering_connection)
  peer_vpc_id = var.vpc_id ? data.aws_vpc.this.id : element(aws_vpc.vpc.*.id, lookup(var.peering_connection[count.index], "peer_vpc_id"))
  vpc_id      = var.vpc_id ? data.aws_vpc.this.id : element(aws_vpc.vpc.*.id, lookup(var.peering_connection[count.index], "vpc_id"))
  auto_accept = lookup(var.peering_connection[count.index], "auto_accept")
  peer_region = lookup(var.peering_connection[count.index], "peer_region")
  tags = merge(
    var.tags,
    lookup(var.peering_connection[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_egress_only_internet_gateway" "this" {
  count = (length(var.vpc) || var.vpc_id != null) == 0 ? 0 : length(var.egress_only)
  vpc_id = var.vpc_id ? data.aws_vpc.this.id : element(aws_vpc.vpc.*.id, lookup(var.egress_only[count.index], "vpc_id"))
  tags = merge(
    var.tags,
    lookup(var.egress_only[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}

resource "aws_ec2_managed_prefix_list" "this" {
  count = length(var.ec2_managed_prefix_list)
  address_family = lookup(var.ec2_managed_prefix_list[count.index], "address_family")
  max_entries    = lookup(var.ec2_managed_prefix_list[count.index], "max_entries")
  name           = lookup(var.ec2_managed_prefix_list[count.index], "name")
  tags = merge(
    var.tags,
    lookup(var.ec2_managed_prefix_list[count.index], "tags"),
    data.aws_default_tags.this.tags
  )

  dynamic "entry" {
    for_each = try(lookup(var.ec2_managed_prefix_list[count.index], "entry") == null ? [] : ["entry"])
    content {
      cidr = element(aws_vpc.vpc.*.cidr_block, lookup(entry.value, "cidr_block_id"))
      description = lookup(entry.value, "description")
    }
  }
}

resource "aws_route_table" "this" {
  count = (length(var.vpc) || var.vpc_id != null) == 0 ? 0 : length(var.route_table)
  vpc_id = element(aws_vpc.vpc.*.id, lookup(var.route_table[count.index], "vpc_id"))
  propagating_vgws = lookup(var.route_table[count.index], "propagating_vgws")
  tags = merge(
    var.tags,
    lookup(var.route_table[count.index], "tags"),
    data.aws_default_tags.this.tags
  )

  dynamic "route" {
    for_each = try(lookup(var.route_table[count.index], "route") == null ? [] : ["route"])
    content {
      // carrier_gateway_id = ""
      cidr_block = try(lookup(route.value, "cidr_block"))
      // core_network_arn = ""
      destination_prefix_list_id = try(element(aws_ec2_managed_prefix_list.this.*.id, lookup(route.value, "destination_prefix_list_id")))
      egress_only_gateway_id = try(element(aws_egress_only_internet_gateway.this.*.id, lookup(route.value, "egress_only_gateway_id")))
      gateway_id = try(length(var.internet_gateway) == null ? "local" : element(aws_internet_gateway.this.*.id, lookup(route.value, "gateway_id")))
      ipv6_cidr_block = try(lookup(route.value, "ipv6_cidr_block"))
      // local_gateway_id = ""
      // nat_gateway_id = ""
      // network_interface_id = ""
      // transit_gateway_id = ""
      // vpc_endpoint_id = ""
      vpc_peering_connection_id = try(var.vpc_id != null ? data.aws_vpc_peering_connection.this.id : element(aws_vpc_peering_connection.this.*.id, lookup(route.value, "vpc_peering_connection_id")))
    }
  }
}

resource "aws_security_group" "this" {
  count = length(var.security_group)
  description = lookup(var.security_group[count.index], "description")
  name = lookup(var.security_group[count.index], "name")
  name_prefix = lookup(var.security_group[count.index], "name_prefix")
  revoke_rules_on_delete = lookup(var.security_group[count.index], "revoke_rules_on_delete")
  vpc_id = element(aws_vpc.vpc.*.id, lookup(var.security_group[count.index], "vpc_id"))
  tags = merge(
    var.tags,
    lookup(var.security_group[count.index], "tags"),
    data.aws_default_tags.this.tags
  )

  dynamic "ingress" {
    for_each = try(lookup(var.security_group[count.index], "ingress") == null ? [] : ["ingress"])
    content {
      from_port = lookup(ingress.value, "from_port")
      to_port = lookup(ingress.value, "to_port")
      protocol = lookup(ingress.value, "protocol")
      cidr_blocks = lookup(ingress.value, "cidr_blocks")
      description = lookup(ingress.value, "description")
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks")
      self = lookup(ingress.value, "self")
    }
  }

  dynamic "egress" {
    for_each = try(lookup(var.security_group[count.index], "egress") == null ? [] : ["egress"])
    content {
      from_port = lookup(egress.value, "from_port")
      to_port = lookup(egress.value, "to_port")
      cidr_blocks = lookup(egress.value, "cidr_blocks")
      description = lookup(egress.value, "description")
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks")
      prefix_list_ids = lookup(egress.value, "prefix_list_ids")
      protocol = lookup(egress.value, "protocol")
      self = lookup(egress.value, "self")
    }
  }
}
