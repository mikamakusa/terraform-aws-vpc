data "aws_region" "this" {}

data "aws_default_tags" "this" {}

/*data "aws_vpc" "this" {
  count = var.vpc_id ? 1 : 0
  id    = var.vpc_id
}

data "aws_vpc_peering_connection" "this" {
  count  = var.vpc_id ? 1 : 0
  vpc_id = data.aws_vpc.this[0].id
}

data "aws_subnet" "this" {}*/

data "aws_availability_zone" "this" {}