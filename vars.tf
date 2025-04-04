variable "ipam" {
  type = list(object({
    id                 = any
    cascade            = optional(bool)
    description        = optional(string)
    enable_private_gua = optional(bool)
    tier               = optional(string)
    tags               = optional(map(string))
  }))
  default = []
}

variable "ipam_pool" {
  type = list(object({
    id                                = any
    address_family                    = string
    ipam_scope_id                     = any
    allocation_default_netmask_length = optional(number)
    allocation_max_netmask_length     = optional(number)
    allocation_min_netmask_length     = optional(number)
    allocation_resource_tags          = optional(map(string))
    auto_import                       = optional(bool)
    aws_service                       = optional(string)
    cascade                           = optional(bool)
    description                       = optional(string)
    publicly_advertisable             = optional(bool)
    public_ip_source                  = optional(string)
    source_ipam_pool_id               = optional(any)
    tags                              = optional(map(string))
  }))
  default = []
}

variable "ipam_pool_cidr" {
  type = list(object({
    id             = any
    ipam_pool_id   = any
    cidr           = optional(string)
    netmask_length = optional(number)
  }))
  default = []
}

variable "vpc" {
  type = list(object({
    id                                   = any
    cidr_block                           = optional(string)
    instance_tenancy                     = optional(string)
    ipv4_ipam_pool_id                    = optional(any)
    ipv4_netmask_length                  = optional(number)
    ipv6_cidr_block                      = optional(string)
    ipv6_cidr_block_network_border_group = optional(string)
    ipv6_ipam_pool_id                    = optional(any)
    ipv6_netmask_length                  = optional(number)
    enable_dns_hostnames                 = optional(bool)
    enable_dns_support                   = optional(bool)
    enable_network_address_usage_metrics = optional(bool)
    assign_generated_ipv6_cidr_block     = optional(bool)
    tags                                 = optional(map(string))
  }))
  default = []
}

variable "internet_gateway" {
  type = list(object({
    id     = any
    vpc_id = optional(any)
    tags   = optional(map(string))
  }))
  default = []
}

variable "peering_connection" {
  type = list(object({
    id          = any
    peer_vpc_id = any
    vpc_id      = any
    auto_accept = optional(bool)
    peer_region = optional(string)
    tags        = optional(map(string))
  }))
  default = []
}

variable "route_table" {
  type = list(object({
    id               = any
    vpc_id           = any
    propagating_vgws = optional(list(any))
    tags             = optional(map(string))
    route = optional(list(object({
      carrier_gateway_id         = optional(any)
      cidr_block_id              = optional(any)
      core_network_id            = optional(any)
      destination_prefix_list_id = optional(any)
      egress_only_gateway_id     = optional(any)
      gateway_id                 = optional(any)
      ipv6_cidr_block            = optional(string)
      local_gateway_id           = optional(any)
      nat_gateway_id             = optional(any)
      network_interface_id       = optional(any)
      transit_gateway_id         = optional(any)
      vpc_endpoint_id            = optional(any)
      vpc_peering_connection_id  = optional(any)
    })), [])
  }))
  default = []
}

variable "egress_only" {
  type = list(object({
    id     = any
    vpc_id = any
    tags   = optional(map(string))
  }))
  default = []
}

variable "ec2_managed_prefix_list" {
  type = list(object({
    id             = any
    address_family = string
    max_entries    = number
    name           = string
    tags           = optional(map(string))
    entry = optional(list(object({
      cidr_block_id = any
      description   = optional(string)
    })), [])
  }))
  default = []
}

variable "security_group" {
  type = list(object({
    id                     = any
    description            = optional(string)
    name                   = optional(string)
    name_prefix            = optional(string)
    revoke_rules_on_delete = optional(bool)
    vpc_id                 = optional(any)
    tags                   = optional(map(string))
    ingress = optional(list(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = optional(list(string))
      description      = optional(string)
      ipv6_cidr_blocks = optional(list(string))
      self             = optional(bool)
    })), [])
    egress = optional(list(object({
      from_port        = number
      to_port          = number
      cidr_blocks      = optional(list(string))
      description      = optional(string)
      ipv6_cidr_blocks = optional(list(string))
      prefix_list_ids  = optional(list(string))
      protocol         = optional(string)
      self             = optional(bool)
    })), [])
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  type    = string
  default = null
}

variable "default_network" {
  type = list(object({
    id                = any
    vpc_id            = any
    tags              = optional(map(string))
    propagating_vgws  = optional(set(string))
    availability_zone = optional(string)
    egress = optional(list(object({
      action           = string
      from_port        = number
      protocol         = string
      rule_no          = number
      to_port          = number
      cidr_blocks      = optional(any)
      description      = optional(any)
      ipv6_cidr_blocks = optional(any)
      prefix_list_ids  = optional(any)
      security_groups  = optional(any)
      self             = optional(any)
    })), [])
    ingress = optional(list(object({
      action           = string
      from_port        = number
      protocol         = string
      rule_no          = number
      to_port          = number
      cidr_blocks      = optional(any)
      description      = optional(any)
      ipv6_cidr_blocks = optional(any)
      prefix_list_ids  = optional(any)
      security_groups  = optional(any)
      self             = optional(any)
    })), [])
    route = optional(list(object({
      cidr_block                = string
      ipv6_cidr_block           = optional(string)
      description               = optional(string)
      destination_prefix        = optional(string)
      core_network_arn          = optional(any)
      egress_from_vpc           = optional(string)
      egress_only_gateway_id    = optional(any)
      gateway_id                = optional(any)
      instance_id               = optional(any)
      nat_gateway_id            = optional(any)
      network_interface_id      = optional(any)
      transit_gateway_id        = optional(any)
      vpc_endpoint_id           = optional(any)
      vpc_peering_connection_id = optional(any)
    })))
  }))
  default = []
}