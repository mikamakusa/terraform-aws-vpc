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
| [aws_default_network_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl) | resource |
| [aws_default_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_default_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_subnet) | resource |
| [aws_ec2_managed_prefix_list.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_egress_only_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/egress_only_internet_gateway) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_ipam.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam) | resource |
| [aws_vpc_ipam_pool.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool_cidr.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |
| [aws_vpc_peering_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc_peering_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_peering_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_network"></a> [default\_network](#input\_default\_network) | n/a | <pre>list(object({<br/>    id                = any<br/>    vpc_id            = any<br/>    tags              = optional(map(string))<br/>    propagating_vgws  = optional(set(string))<br/>    availability_zone = optional(string)<br/>    egress = optional(list(object({<br/>      action           = string<br/>      from_port        = number<br/>      protocol         = string<br/>      rule_no          = number<br/>      to_port          = number<br/>      cidr_blocks      = optional(any)<br/>      description      = optional(any)<br/>      ipv6_cidr_blocks = optional(any)<br/>      prefix_list_ids  = optional(any)<br/>      security_groups  = optional(any)<br/>      self             = optional(any)<br/>    })), [])<br/>    ingress = optional(list(object({<br/>      action           = string<br/>      from_port        = number<br/>      protocol         = string<br/>      rule_no          = number<br/>      to_port          = number<br/>      cidr_blocks      = optional(any)<br/>      description      = optional(any)<br/>      ipv6_cidr_blocks = optional(any)<br/>      prefix_list_ids  = optional(any)<br/>      security_groups  = optional(any)<br/>      self             = optional(any)<br/>    })), [])<br/>    route = optional(list(object({<br/>      cidr_block                = string<br/>      ipv6_cidr_block           = optional(string)<br/>      description               = optional(string)<br/>      destination_prefix        = optional(string)<br/>      core_network_arn          = optional(any)<br/>      egress_from_vpc           = optional(string)<br/>      egress_only_gateway_id    = optional(any)<br/>      gateway_id                = optional(any)<br/>      instance_id               = optional(any)<br/>      nat_gateway_id            = optional(any)<br/>      network_interface_id      = optional(any)<br/>      transit_gateway_id        = optional(any)<br/>      vpc_endpoint_id           = optional(any)<br/>      vpc_peering_connection_id = optional(any)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_ec2_managed_prefix_list"></a> [ec2\_managed\_prefix\_list](#input\_ec2\_managed\_prefix\_list) | n/a | <pre>list(object({<br/>    id             = any<br/>    address_family = string<br/>    max_entries    = number<br/>    name           = string<br/>    tags           = optional(map(string))<br/>    entry = optional(list(object({<br/>      cidr_block_id = any<br/>      description   = optional(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_egress_only"></a> [egress\_only](#input\_egress\_only) | n/a | <pre>list(object({<br/>    id     = any<br/>    vpc_id = any<br/>    tags   = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_internet_gateway"></a> [internet\_gateway](#input\_internet\_gateway) | n/a | <pre>list(object({<br/>    id     = any<br/>    vpc_id = optional(any)<br/>    tags   = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_ipam"></a> [ipam](#input\_ipam) | n/a | <pre>list(object({<br/>    id                 = any<br/>    cascade            = optional(bool)<br/>    description        = optional(string)<br/>    enable_private_gua = optional(bool)<br/>    tier               = optional(string)<br/>    tags               = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_ipam_pool"></a> [ipam\_pool](#input\_ipam\_pool) | n/a | <pre>list(object({<br/>    id                                = any<br/>    address_family                    = string<br/>    ipam_scope_id                     = any<br/>    allocation_default_netmask_length = optional(number)<br/>    allocation_max_netmask_length     = optional(number)<br/>    allocation_min_netmask_length     = optional(number)<br/>    allocation_resource_tags          = optional(map(string))<br/>    auto_import                       = optional(bool)<br/>    aws_service                       = optional(string)<br/>    cascade                           = optional(bool)<br/>    description                       = optional(string)<br/>    publicly_advertisable             = optional(bool)<br/>    public_ip_source                  = optional(string)<br/>    source_ipam_pool_id               = optional(any)<br/>    tags                              = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_ipam_pool_cidr"></a> [ipam\_pool\_cidr](#input\_ipam\_pool\_cidr) | n/a | <pre>list(object({<br/>    id             = any<br/>    ipam_pool_id   = any<br/>    cidr           = optional(string)<br/>    netmask_length = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_peering_connection"></a> [peering\_connection](#input\_peering\_connection) | n/a | <pre>list(object({<br/>    id          = any<br/>    peer_vpc_id = any<br/>    vpc_id      = any<br/>    auto_accept = optional(bool)<br/>    peer_region = optional(string)<br/>    tags        = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_route_table"></a> [route\_table](#input\_route\_table) | n/a | <pre>list(object({<br/>    id               = any<br/>    vpc_id           = any<br/>    propagating_vgws = optional(list(any))<br/>    tags             = optional(map(string))<br/>    route = optional(list(object({<br/>      carrier_gateway_id         = optional(any)<br/>      cidr_block_id              = optional(any)<br/>      core_network_id            = optional(any)<br/>      destination_prefix_list_id = optional(any)<br/>      egress_only_gateway_id     = optional(any)<br/>      gateway_id                 = optional(any)<br/>      ipv6_cidr_block            = optional(string)<br/>      local_gateway_id           = optional(any)<br/>      nat_gateway_id             = optional(any)<br/>      network_interface_id       = optional(any)<br/>      transit_gateway_id         = optional(any)<br/>      vpc_endpoint_id            = optional(any)<br/>      vpc_peering_connection_id  = optional(any)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | n/a | <pre>list(object({<br/>    id                     = any<br/>    description            = optional(string)<br/>    name                   = optional(string)<br/>    name_prefix            = optional(string)<br/>    revoke_rules_on_delete = optional(bool)<br/>    vpc_id                 = optional(any)<br/>    tags                   = optional(map(string))<br/>    ingress = optional(list(object({<br/>      from_port        = number<br/>      to_port          = number<br/>      protocol         = string<br/>      cidr_blocks      = optional(list(string))<br/>      description      = optional(string)<br/>      ipv6_cidr_blocks = optional(list(string))<br/>      self             = optional(bool)<br/>    })), [])<br/>    egress = optional(list(object({<br/>      from_port        = number<br/>      to_port          = number<br/>      cidr_blocks      = optional(list(string))<br/>      description      = optional(string)<br/>      ipv6_cidr_blocks = optional(list(string))<br/>      prefix_list_ids  = optional(list(string))<br/>      protocol         = optional(string)<br/>      self             = optional(bool)<br/>    })), [])<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>list(object({<br/>    id                                   = any<br/>    cidr_block                           = optional(string)<br/>    instance_tenancy                     = optional(string)<br/>    ipv4_ipam_pool_id                    = optional(any)<br/>    ipv4_netmask_length                  = optional(number)<br/>    ipv6_cidr_block                      = optional(string)<br/>    ipv6_cidr_block_network_border_group = optional(string)<br/>    ipv6_ipam_pool_id                    = optional(any)<br/>    ipv6_netmask_length                  = optional(number)<br/>    enable_dns_hostnames                 = optional(bool)<br/>    enable_dns_support                   = optional(bool)<br/>    enable_network_address_usage_metrics = optional(bool)<br/>    assign_generated_ipv6_cidr_block     = optional(bool)<br/>    tags                                 = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_managed_list_prefix_name"></a> [ec2\_managed\_list\_prefix\_name](#output\_ec2\_managed\_list\_prefix\_name) | n/a |
| <a name="output_ec2_managed_prefix_list_arn"></a> [ec2\_managed\_prefix\_list\_arn](#output\_ec2\_managed\_prefix\_list\_arn) | n/a |
| <a name="output_ec2_managed_prefix_list_id"></a> [ec2\_managed\_prefix\_list\_id](#output\_ec2\_managed\_prefix\_list\_id) | n/a |
| <a name="output_egress_only_internet_gateway_id"></a> [egress\_only\_internet\_gateway\_id](#output\_egress\_only\_internet\_gateway\_id) | n/a |
| <a name="output_internet_gateway_arn"></a> [internet\_gateway\_arn](#output\_internet\_gateway\_arn) | n/a |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | n/a |
| <a name="output_ipam_arn"></a> [ipam\_arn](#output\_ipam\_arn) | n/a |
| <a name="output_ipam_id"></a> [ipam\_id](#output\_ipam\_id) | n/a |
| <a name="output_ipam_pool_arn"></a> [ipam\_pool\_arn](#output\_ipam\_pool\_arn) | n/a |
| <a name="output_ipam_pool_cidr"></a> [ipam\_pool\_cidr](#output\_ipam\_pool\_cidr) | n/a |
| <a name="output_ipam_pool_cidr_id"></a> [ipam\_pool\_cidr\_id](#output\_ipam\_pool\_cidr\_id) | n/a |
| <a name="output_ipam_pool_id"></a> [ipam\_pool\_id](#output\_ipam\_pool\_id) | n/a |
| <a name="output_peering_connection_id"></a> [peering\_connection\_id](#output\_peering\_connection\_id) | n/a |
| <a name="output_route_table_arn"></a> [route\_table\_arn](#output\_route\_table\_arn) | n/a |
| <a name="output_route_table_id"></a> [route\_table\_id](#output\_route\_table\_id) | n/a |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | n/a |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
