## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_ipam.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam) | resource |
| [aws_vpc_ipam_pool.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool_cidr.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ipam"></a> [ipam](#input\_ipam) | n/a | <pre>list(object({<br/>    id = any<br/>    cascade = optional(bool)<br/>    description = optional(string)<br/>    enable_private_gua = optional(bool)<br/>    tier = optional(string)<br/>    tags = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_ipam_pool"></a> [ipam\_pool](#input\_ipam\_pool) | n/a | <pre>list(object({<br/>    id = any<br/>    address_family = string<br/>    ipam_scope_id  = any<br/>    allocation_default_netmask_length = optional(number)<br/>    allocation_max_netmask_length = optional(number)<br/>    allocation_min_netmask_length = optional(number)<br/>    allocation_resource_tags = optional(map(string))<br/>    auto_import = optional(bool)<br/>    aws_service = optional(string)<br/>    cascade = optional(bool)<br/>    description = optional(string)<br/>    publicly_advertisable = optional(bool)<br/>    public_ip_source = optional(string)<br/>    source_ipam_pool_id = optional(any)<br/>    tags = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_ipam_pool_cidr"></a> [ipam\_pool\_cidr](#input\_ipam\_pool\_cidr) | n/a | <pre>list(object({<br/>    id = any<br/>    ipam_pool_id = any<br/>    cidr = optional(string)<br/>    netmask_length = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>list(object({<br/>    id = any<br/>    cidr_block                       = optional(string)<br/>    instance_tenancy                 = optional(string)<br/>    ipv4_ipam_pool_id = optional(any)<br/>    ipv4_netmask_length = optional(number)<br/>    ipv6_cidr_block = optional(string)<br/>    ipv6_cidr_block_network_border_group = optional(string)<br/>    ipv6_ipam_pool_id = optional(any)<br/>    ipv6_netmask_length = optional(number)<br/>    enable_dns_hostnames             = optional(bool)<br/>    enable_dns_support               = optional(bool)<br/>    enable_network_address_usage_metrics = optional(bool)<br/>    assign_generated_ipv6_cidr_block = optional(bool)<br/>    tags                             = optional(map(string))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
