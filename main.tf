resource "aws_vpc_ipam" "this" {
  count              = length(var.ipam)
  cascade            = lookup(var.ipam[count.index], "cascade")
  description        = lookup(var.ipam[count.index], "description")
  enable_private_gua = lookup(var.ipam[count.index], "enable_private_gua")
  tier               = lookup(var.ipam[count.index], "tier")
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
  count                             = length(var.ipam) == 0 ? 0 : length(var.ipam_pool)
  address_family                    = lookup(var.ipam_pool[count.index], "address_family")
  ipam_scope_id                     = element(aws_vpc_ipam.this.*.private_default_scope_id, lookup(var.ipam_pool[count.index], "ipam_scope_id"))
  allocation_default_netmask_length = lookup(var.ipam_pool[count.index], "allocation_default_netmask_length")
  allocation_max_netmask_length     = lookup(var.ipam_pool[count.index], "allocation_max_netmask_length")
  allocation_min_netmask_length     = lookup(var.ipam_pool[count.index], "allocation_min_netmask_length")
  allocation_resource_tags          = lookup(var.ipam_pool[count.index], "allocation_resource_tags")
  auto_import                       = lookup(var.ipam_pool[count.index], "auto_import")
  aws_service                       = lookup(var.ipam_pool[count.index], "aws_service")
  cascade                           = lookup(var.ipam_pool[count.index], "cascade")
  description                       = lookup(var.ipam_pool[count.index], "description")
  locale                            = data.aws_region.this.name
  publicly_advertisable             = lookup(var.ipam_pool[count.index], "publicly_advertisable")
  public_ip_source                  = lookup(var.ipam_pool[count.index], "public_ip_source")
  source_ipam_pool_id               = element(aws_vpc_ipam.this.*.id, lookup(var.ipam_pool[count.index], "source_ipam_pool_id"))
  tags = merge(
    var.tags,
    lookup(var.ipam_pool[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}

resource "aws_vpc_ipam_pool_cidr" "this" {
  count          = length(var.ipam_pool) == 0 ? 0 : length(var.ipam_pool_cidr)
  ipam_pool_id   = element(aws_vpc_ipam_pool.this.*.id, lookup(var.ipam_pool_cidr[count.index], "ipam_pool_id"))
  cidr           = lookup(var.ipam_pool_cidr[count.index], "cidr")
  netmask_length = lookup(var.ipam_pool_cidr[count.index], "netmask_length")
}

resource "aws_vpc" "this" {
  count                                = length(var.vpc)
  cidr_block                           = lookup(var.vpc[count.index], "cidr_block")
  instance_tenancy                     = lookup(var.vpc[count.index], "instance_tenancy")
  ipv4_ipam_pool_id                    = try(element(aws_vpc_ipam_pool.this.*.id, lookup(var.vpc[count.index], "ipv4_ipam_pool_id")))
  ipv4_netmask_length                  = lookup(var.vpc[count.index], "ipv4_netmask_length")
  ipv6_cidr_block                      = lookup(var.vpc[count.index], "ipv6_cidr_block")
  ipv6_cidr_block_network_border_group = lookup(var.vpc[count.index], "ipv6_cidr_block_network_border_group")
  ipv6_ipam_pool_id                    = try(element(aws_vpc_ipam_pool.this.*.id, lookup(var.vpc[count.index], "ipv6_ipam_pool_id")))
  ipv6_netmask_length                  = lookup(var.vpc[count.index], "ipv6_netmask_length")
  enable_dns_hostnames                 = lookup(var.vpc[count.index], "enable_dns_hostnames", false)
  enable_dns_support                   = lookup(var.vpc[count.index], "enable_dns_support", false)
  enable_network_address_usage_metrics = lookup(var.vpc[count.index], "enable_network_address_usage_metrics")
  assign_generated_ipv6_cidr_block     = lookup(var.vpc[count.index], "assign_generated_ipv6_cidr_block", false)
  tags = merge(
    var.tags,
    lookup(var.vpc[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}

resource "aws_internet_gateway" "this" {
  count  = length(var.internet_gateway)
  vpc_id = element(aws_vpc.this.*.id, lookup(var.internet_gateway[count.index], "vpc_id"))
  tags = merge(
    var.tags,
    lookup(var.internet_gateway[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}

resource "aws_vpc_peering_connection" "this" {
  count       = (length(var.vpc) || var.vpc_id != null) == 0 ? 0 : length(var.peering_connection)
  peer_vpc_id = var.vpc_id ? data.aws_vpc.this.id : element(aws_vpc.this.*.id, lookup(var.peering_connection[count.index], "peer_vpc_id"))
  vpc_id      = var.vpc_id ? data.aws_vpc.this.id : element(aws_vpc.this.*.id, lookup(var.peering_connection[count.index], "vpc_id"))
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
  count  = (length(var.vpc) || var.vpc_id != null) == 0 ? 0 : length(var.egress_only)
  vpc_id = var.vpc_id ? data.aws_vpc.this.id : element(aws_vpc.this.*.id, lookup(var.egress_only[count.index], "vpc_id"))
  tags = merge(
    var.tags,
    lookup(var.egress_only[count.index], "tags"),
    data.aws_default_tags.this.tags
  )
}

resource "aws_ec2_managed_prefix_list" "this" {
  count          = length(var.ec2_managed_prefix_list)
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
      cidr        = element(aws_vpc.this.*.cidr_block, lookup(entry.value, "cidr_block_id"))
      description = lookup(entry.value, "description")
    }
  }
}

resource "aws_route_table" "this" {
  count            = (length(var.vpc) || var.vpc_id != null) == 0 ? 0 : length(var.route_table)
  vpc_id           = element(aws_vpc.this.*.id, lookup(var.route_table[count.index], "vpc_id"))
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
      egress_only_gateway_id     = try(element(aws_egress_only_internet_gateway.this.*.id, lookup(route.value, "egress_only_gateway_id")))
      gateway_id                 = try(length(var.internet_gateway) == null ? "local" : element(aws_internet_gateway.this.*.id, lookup(route.value, "gateway_id")))
      ipv6_cidr_block            = try(lookup(route.value, "ipv6_cidr_block"))
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
  count                  = length(var.security_group)
  description            = lookup(var.security_group[count.index], "description")
  name                   = lookup(var.security_group[count.index], "name")
  name_prefix            = lookup(var.security_group[count.index], "name_prefix")
  revoke_rules_on_delete = lookup(var.security_group[count.index], "revoke_rules_on_delete")
  vpc_id                 = element(aws_vpc.this.*.id, lookup(var.security_group[count.index], "vpc_id"))
  tags = merge(
    var.tags,
    lookup(var.security_group[count.index], "tags"),
    data.aws_default_tags.this.tags
  )

  dynamic "ingress" {
    for_each = try(lookup(var.security_group[count.index], "ingress") == null ? [] : ["ingress"])
    content {
      from_port        = lookup(ingress.value, "from_port")
      to_port          = lookup(ingress.value, "to_port")
      protocol         = lookup(ingress.value, "protocol")
      cidr_blocks      = lookup(ingress.value, "cidr_blocks")
      description      = lookup(ingress.value, "description")
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks")
      self             = lookup(ingress.value, "self")
    }
  }

  dynamic "egress" {
    for_each = try(lookup(var.security_group[count.index], "egress") == null ? [] : ["egress"])
    content {
      from_port        = lookup(egress.value, "from_port")
      to_port          = lookup(egress.value, "to_port")
      cidr_blocks      = lookup(egress.value, "cidr_blocks")
      description      = lookup(egress.value, "description")
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks")
      prefix_list_ids  = lookup(egress.value, "prefix_list_ids")
      protocol         = lookup(egress.value, "protocol")
      self             = lookup(egress.value, "self")
    }
  }
}

resource "aws_default_network_acl" "this" {
  count                  = length(var.vpc) == 0 ? 0 : length(var.default_network)
  default_network_acl_id = element(aws_vpc.this.*.default_network_acl_id, lookup(var.default_network[count.index], "vpc_id"))
  tags = merge(
    var.tags,
    data.aws_default_tags.this.tags,
    lookup(var.default_network[count.index], "tags")
  )

  dynamic "egress" {
    for_each = try(lookup(var.default_network[count.index], "egress") == null ? [] : ["egress"])
    content {
      action    = lookup(egress.value, "action")
      from_port = lookup(egress.value, "from_port")
      protocol  = lookup(egress.value, "protocol")
      rule_no   = lookup(egress.value, "rule_no")
      to_port   = lookup(egress.value, "to_port")
    }
  }
  dynamic "ingress" {
    for_each = try(lookup(var.default_network[count.index], "ingress") == null ? [] : ["ingress"])
    content {
      action    = lookup(ingress.value, "action")
      from_port = lookup(ingress.value, "from_port")
      protocol  = lookup(ingress.value, "protocol")
      rule_no   = lookup(ingress.value, "rule_no")
      to_port   = lookup(ingress.value, "to_port")
    }
  }
}

resource "aws_default_route_table" "this" {
  count                  = length(var.vpc) == 0 ? 0 : length(var.default_network)
  default_route_table_id = element(aws_vpc.this.*.default_route_table_id, lookup(var.default_network[count.index], "vpc_id"))
  propagating_vgws       = lookup(var.default_network[count.index], "propagating_vgws")
  tags = merge(
    var.tags,
    data.aws_default_tags.this.tags,
    lookup(var.default_network[count.index], "tags")
  )

  dynamic "route" {
    for_each = try(lookup(var.default_network[count.index], "route") == null ? [] : ["route"])
    content {
      cidr_block                = lookup(route.value, "cidr_block")
      ipv6_cidr_block           = lookup(route.value, "interface_index")
      description               = lookup(route.value, "description")
      destination_prefix        = lookup(route.value, "destination_prefix")
      core_network_arn          = lookup(route.value, "core_network_arn")
      egress_from_vpc           = lookup(route.value, "egress_from_vpc")
      egress_only_gateway_id    = try(element(aws_egress_only_internet_gateway.this.*.id, lookup(route.value, "egress_only_gateway_id")))
      gateway_id                = try(element(aws_internet_gateway.this.*.id, lookup(route.value, "gateway_id")))
      instance_id               = lookup(route.value, "instance_id")
      nat_gateway_id            = lookup(route.value, "nat_gateway_id")
      network_interface_id      = lookup(route.value, "network_interface_id")
      transit_gateway_id        = lookup(route.value, "transit_gateway_id")
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id")
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id")
    }
  }
}

resource "aws_default_security_group" "this" {
  count  = length(var.vpc) == 0 ? 0 : length(var.default_network)
  vpc_id = element(aws_vpc.this.*.default_route_table_id, lookup(var.default_network[count.index], "vpc_id"))
  tags = merge(
    var.tags,
    data.aws_default_tags.this.tags,
    lookup(var.default_network[count.index], "tags")
  )

  dynamic "egress" {
    for_each = try(lookup(var.default_network[count.index], "egress") == null ? [] : ["egress"])
    content {
      cidr_blocks      = [lookup(egress.value, "default_cidr_blocks")]
      description      = lookup(egress.value, "default_cidr_block")
      from_port        = lookup(egress.value, "from_port")
      to_port          = lookup(egress.value, "to_port")
      protocol         = lookup(egress.value, "protocol")
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks")
      prefix_list_ids  = lookup(egress.value, "prefix_list_ids")
      security_groups  = lookup(egress.value, "security_groups")
      self             = lookup(egress.value, "self")
    }
  }

  dynamic "ingress" {
    for_each = try(lookup(var.default_network[count.index], "ingress") == null ? [] : ["ingress"])
    content {
      cidr_blocks      = [lookup(ingress.value, "default_cidr_blocks")]
      description      = lookup(ingress.value, "default_cidr_block")
      from_port        = lookup(ingress.value, "from_port")
      to_port          = lookup(ingress.value, "to_port")
      protocol         = lookup(ingress.value, "protocol")
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks")
      prefix_list_ids  = lookup(ingress.value, "prefix_list_ids")
      security_groups  = lookup(ingress.value, "security_groups")
      self             = lookup(ingress.value, "self")
    }
  }
}

resource "aws_default_subnet" "this" {
  count             = length(var.vpc) == 0 ? 0 : length(var.default_network)
  availability_zone = lookup(var.default_network[count.index], "availability_zone")
  force_destroy     = true
}

resource "aws_subnet" "this" {
  count                                          = (length(var.vpc) || var.vpc_id != null) == 0 ? 0 : length(var.subnet)
  vpc_id                                         = try(var.vpc_id != null ? data.aws_vpc.this.id : element(aws_vpc.this.*.id, lookup(var.subnet[count.index], "vpc_id")))
  assign_ipv6_address_on_creation                = lookup(var.subnet[count.index], "assign_ipv6_address_on_creation")
  availability_zone                              = lookup(var.subnet[count.index], "availability_zone")
  availability_zone_id                           = try(data.aws_availability_zone.this.id)
  cidr_block                                     = lookup(var.subnet[count.index], "cidr_block")
  customer_owned_ipv4_pool                       = lookup(var.subnet[count.index], "customer_owned_ipv4_pool")
  enable_dns64                                   = lookup(var.subnet[count.index], "enable_dns64")
  enable_lni_at_device_index                     = lookup(var.subnet[count.index], "enable_lni_at_device_index")
  enable_resource_name_dns_a_record_on_launch    = lookup(var.subnet[count.index], "enable_resource_name_dns_a_record_on_launch")
  enable_resource_name_dns_aaaa_record_on_launch = lookup(var.subnet[count.index], "enable_resource_name_dns_aaaa_record_on_launch")
  ipv6_cidr_block                                = lookup(var.subnet[count.index], "ipv6_cidr_block")
  ipv6_native                                    = lookup(var.subnet[count.index], "ipv6_native")
  map_customer_owned_ip_on_launch                = lookup(var.subnet[count.index], "map_customer_owned_ip_on_launch")
  map_public_ip_on_launch                        = lookup(var.subnet[count.index], "map_public_ip_on_launch")
  outpost_arn                                    = lookup(var.subnet[count.index], "outpost_arn")
  tags = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.subnet[count.index], "tags")
  )
}

resource "aws_eip" "this" {
  count                     = length(var.eip)
  address                   = lookup(var.eip[count.index], "address")
  associate_with_private_ip = lookup(var.eip[count.index], "associate_with_private_ip")
  customer_owned_ipv4_pool  = lookup(var.eip[count.index], "customer_owned_ipv4_pool")
  domain                    = lookup(var.eip[count.index], "domain")
  instance                  = lookup(var.eip[count.index], "instance")
  network_border_group      = lookup(var.eip[count.index], "network_border_group")
  network_interface         = lookup(var.eip[count.index], "network_interface")
  public_ipv4_pool          = lookup(var.eip[count.index], "public_ipv4_pool")
  tags = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.eip[count.index], "tags")
  )
}

resource "aws_vpc_endpoint" "this" {
  count        = (length(var.vpc) || var.vpc_id != null) == 0 ? 0 : length(var.vpc_endpoint)
  service_name = lookup(var.vpc_endpoint[count.index], "service_name")
  vpc_id = try(
    var.vpc_id != null ? data.aws_vpc.this.id : element(
      aws_vpc.this.*.id, lookup(var.vpc_endpoint[count.index], "vpc_id")
    )
  )
  auto_accept         = lookup(var.vpc_endpoint[count.index], "auto_accept")
  ip_address_type     = lookup(var.vpc_endpoint[count.index], "ip_address_type")
  policy              = lookup(var.vpc_endpoint[count.index], "policy")
  private_dns_enabled = lookup(var.vpc_endpoint[count.index], "private_dns_enabled")
  route_table_ids     = try(element(aws_route_table.this.*.id, lookup(var.vpc_endpoint[count.index], "route_table_ids")))
  security_group_ids  = try(element(aws_security_group.this.*.id, lookup(var.vpc_endpoint[count.index], "security_group_ids")))
  subnet_ids          = try(element(aws_subnet.this.*.id, lookup(var.vpc_endpoint[count.index], "subnet_ids")))
  tags = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.vpc_endpoint[count.index], "tags")
  )
  vpc_endpoint_type = lookup(var.vpc_endpoint[count.index], "vpc_endpoint_type")

  dynamic "dns_options" {
    for_each = lookup(var.vpc_endpoint[count.index], "dns_options") == null ? [] : ["dns_options"]
    content {
      dns_record_ip_type                             = lookup(dns_options.value, "dns_record_ip_type")
      private_dns_only_for_inbound_resolver_endpoint = lookup(dns_options.value, "private_dns_only_for_inbound_resolver_endpoint")
    }
  }

  dynamic "subnet_configuration" {
    for_each = lookup(var.vpc_endpoint[count.index], "subnet_configuration") == null ? [] : ["subnet_configuration"]
    content {
      ipv4      = lookup(subnet_configuration.value, "ipv4")
      ipv6      = lookup(subnet_configuration.value, "ipv6")
      subnet_id = try(element(aws_subnet.this.*.id, lookup(subnet_configuration.value, "subnet_id")))
    }
  }
}