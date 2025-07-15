output "vpc" {
  description = "Informations relatives au VPC."
  value = {
    for a, b in aws_vpc.this : a => {
      arn                                  = a.arn
      id                                   = a.id
      instance_tenancy                     = a.instance_tenancy
      dhcp_options_id                      = a.dhcp_options_id
      enable_dns_support                   = a.enable_dns_support
      enable_network_address_usage_metrics = a.enable_network_address_usage_metrics
      enable_dns_hostnames                 = a.enable_dns_hostnames
      main_route_table_id                  = a.main_route_table_id
      default_network_acl_id               = a.default_network_acl_id
      default_security_group_id            = a.default_security_group_id
      default_route_table_id               = a.default_route_table_id
      ipv6_association_id                  = a.ipv6_association_id
      ipv6_cidr_block_network_border_group = a.ipv6_cidr_block_network_border_group
      owner_id                             = a.owner_id
      tags_all                             = a.tags_all
    }
  }
}

output "ipam" {
  description = "Informations relatives à la ressource IPAM."
  value = {
    for a, b in aws_vpc_ipam.this : a => {
      arn                                       = a.arn
      id                                        = a.id
      default_resource_discovery_id             = a.default_resource_discovery_id
      default_resource_discovery_association_id = a.default_resource_discovery_association_id
      private_default_scope_id                  = a.private_default_scope_id
      public_default_scope_id                   = a.public_default_scope_id
      scope_count                               = a.scope_count
      tags_all                                  = a.tags_all
    }
  }
}

output "ipam_pool" {
  description = "Informations relatives au pool de la ressource IPAM."
  value = {
    for a, b in aws_vpc_ipam_pool.this : a => {
      arn      = a.arn
      id       = a.id
      state    = a.state
      tags_all = a.tags_all
    }
  }
}

output "ipam_pool_cidr" {
  description = "Informations relatives au CIDR du pool de la ressource IPAM."
  value = {
    for a, b in aws_vpc_ipam_pool_cidr.this : a => {
      id                         = a.id
      ipam_pool_cidr_id          = a.ipam_pool_cidr_id
      cidr_authorization_context = a.cidr_authorization_context
      netmask_length             = a.netmask_length
    }
  }
}

output "internet_gateway" {
  value = {
    for a, b in aws_internet_gateway.this : a => {
      id       = a.id
      arn      = a.arn
      owner_id = a.owner_id
      tags_all = a.tags_all
    }
  }
}

output "peering_connection" {
  value = {
    for a, b in aws_vpc_peering_connection.this : a => {
      id            = a.id
      accept_status = a.accept_status
      tags_all      = a.tags_all
      auto_accept   = a.auto_accept
    }
  }
}

output "egress_only_internet_gateway" {
  value = {
    for a, b in aws_egress_only_internet_gateway.this : a => {
      id       = a.id
      tags_all = a.tags_all
    }
  }
}

output "ec2_managed_prefix_list" {
  value = {
    for a, b in aws_ec2_managed_prefix_list.this : a => {
      id             = a.id
      tags_all       = a.tags_all
      arn            = a.arn
      name           = a.name
      address_family = a.address_family
      owner_id       = a.owner_id
      max_entries    = a.max_entries
    }
  }
}

output "route_table" {
  value = {
    for a, b in aws_route_table.this : a => {
      id       = a.id
      tags_all = a.tags_all
      arn      = a.arn
      owner_id = a.owner_id
    }
  }
}

output "security_group" {
  value = {
    for a, b in aws_security_group.this : a => {
      id       = a.id
      tags_all = a.tags_all
      arn      = a.arn
      owner_id = a.owner_id
    }
  }
}

output "aws_subnet" {
  value = {
    for a, b in aws_subnet.this : a => {
      id                             = a.id
      tags_all                       = a.tags_all
      arn                            = a.arn
      owner_id                       = a.owner_id
      ipv6_cidr_block_association_id = a.ipv6_cidr_block_association_id
    }
  }
}

## aws_eip
output "aws_eip" {
  value = {
    for a, b in aws_eip.this : a => {
      id                        = a.id
      tags_all                  = a.tags_all
      arn                       = a.arn
      public_ip                 = a.public_ip
      allocation_id             = a.allocation_id
      associate_with_private_ip = a.associate_with_private_ip
      carrier_ip                = a.carrier_ip
    }
  }
}

output "aws_vpc_endpoint" {
  value = {
    for a, b in aws_vpc_endpoint.this : a => {
      arn         = a.arn
      owner_id    = a.owner_id
      id          = a.id
      tags_all    = a.tags_all
      auto_accept = a.auto_accept
      cidr_blocks = a.cidr_blocks
    }
  }
}