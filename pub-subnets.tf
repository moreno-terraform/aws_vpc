module "pub_subnets" {
  count = length(var.pub_subnets_cidr_block) > 0 ? 1 : 0

  source = "git::https://github.com/moreno-terraform/aws_subnets.git?ref=1.0"

  vpc_id = aws_vpc.vpc.id
  vpc_name = var.vpc_name
  subnet_group_name = var.pub_subnet_group_name
  subnets_cidr_block = var.pub_subnets_cidr_block
  map_public_ip_on_launch = true
  tags = var.tags
}
output "pub_subnet_ids" {
  value = length(var.pub_subnets_cidr_block) > 0 ? module.pub_subnets[0].subnet_ids : []
}
output "pub_route_table_id" {
  value = length(var.pub_subnets_cidr_block) > 0 ? module.pub_subnets[0].route_table_id : null
}