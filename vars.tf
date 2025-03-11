variable "ipam" {
  type = list(object({
    id = any
    cascade = optional(bool)
    description = optional(string)
    enable_private_gua = optional(bool)
    tier = optional(string)
    tags = optional(map(string))
  }))
  default = []
}

variable "ipam_pool" {
  type = list(object({
    id = any
    address_family = string
    ipam_scope_id  = any
    allocation_default_netmask_length = optional(number)
    allocation_max_netmask_length = optional(number)
    allocation_min_netmask_length = optional(number)
    allocation_resource_tags = optional(map(string))
    auto_import = optional(bool)
    aws_service = optional(string)
    cascade = optional(bool)
    description = optional(string)
    publicly_advertisable = optional(bool)
    public_ip_source = optional(string)
    source_ipam_pool_id = optional(any)
    tags = optional(map(string))
  }))
  default = []
}

variable "ipam_pool_cidr" {
  type = list(object({
    id = any
    ipam_pool_id = any
    cidr = optional(string)
    netmask_length = optional(number)
  }))
  default = []
}

variable "vpc" {
  type = list(object({
    id = any
    cidr_block                       = optional(string)
    instance_tenancy                 = optional(string)
    ipv4_ipam_pool_id = optional(any)
    ipv4_netmask_length = optional(number)
    ipv6_cidr_block = optional(string)
    ipv6_cidr_block_network_border_group = optional(string)
    ipv6_ipam_pool_id = optional(any)
    ipv6_netmask_length = optional(number)
    enable_dns_hostnames             = optional(bool)
    enable_dns_support               = optional(bool)
    enable_network_address_usage_metrics = optional(bool)
    assign_generated_ipv6_cidr_block = optional(bool)
    tags                             = optional(map(string))
  }))
  default = []
}

variable "tags" {}