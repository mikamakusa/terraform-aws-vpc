## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| tags | n/a | `any` | n/a | yes |
| vpc | n/a | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_arn | n/a |
| vpc\_id | n/a |

## How to use it

### main.tf
```hcl
module "vpc" {
  source = "vpc"
  tags   = local.vpc_tags
  vpc    = var.vpc
}
```

### vars.tf
```hcl
variable "vpc" {
  type = list
}
```

### vars.tfvars
```hcl
vpc = [
  {
    id                   = "0"
    cidr_block           = "10.10.0.0/16"
    instance_tenancy     = "default"
    enable_dns_hostnames = "true"
    enable_dns_support   = "true"
  }
]
```
