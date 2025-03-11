output "vpc_id" {
  value = aws_vpc.vpc.*.id
}

output "vpc_arn" {
  value = aws_vpc.vpc.*.arn
}

output "ipam_id" {
  value = try(aws_vpc_ipam.this.*.id)
}

output "ipam_arn" {
  value = try(aws_vpc_ipam.this.*.arn)
}

output "ipam_pool_id" {
  value = try(aws_vpc_ipam_pool.this.*.id)
}

output "ipam_pool_arn" {
  value = try(aws_vpc_ipam_pool.this.*.arn)
}

output "ipam_pool_cidr_id" {
  value = try(aws_vpc_ipam_pool_cidr.this.*.id)
}

output "ipam_pool_cidr" {
  value = try(aws_vpc_ipam_pool_cidr.this.*.cidr)
}

output "internet_gateway_id" {
  value = try(aws_internet_gateway.this.*.id)
}

output "internet_gateway_arn" {
  value = try(aws_internet_gateway.this.*.arn)
}

output "peering_connection_id" {
  value = try(aws_vpc_peering_connection.this.*.id)
}

output "egress_only_internet_gateway_id" {
  value = try(aws_egress_only_internet_gateway.this.*.id)
}

output "ec2_managed_prefix_list_id" {
  value = try(aws_ec2_managed_prefix_list.this.*.id)
}

output "ec2_managed_prefix_list_arn" {
  value = try(aws_ec2_managed_prefix_list.this.*.arn)
}

output "ec2_managed_list_prefix_name" {
  value = try(aws_ec2_managed_prefix_list.this.*.name)
}

output "route_table_id" {
  value = try(aws_route_table.this.*.id)
}

output "route_table_arn" {
  value = try(aws_route_table.this.*.arn)
}

output "security_group_id" {
  value = try(aws_security_group.this.*.id)
}

output "security_group_arn" {
  value = try(aws_security_group.this.*.arn)
}

output "security_group_name" {
  value = try(aws_security_group.this.*.name)
}