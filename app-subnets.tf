module "app_subnets" {
  count = length(var.app_subnets_cidr_block) > 0 ? 1 : 0

  source = "git::https://github.com/moreno-terraform/aws_subnets.git?ref=1.0"

  vpc_id = aws_vpc.vpc.id
  vpc_name = var.vpc_name
  subnet_group_name = var.app_subnet_group_name
  subnets_cidr_block = var.app_subnets_cidr_block
  map_public_ip_on_launch = false
  tags = var.tags
}
output "app_subnet_ids" {
  value = length(var.app_subnets_cidr_block) > 0 ? module.app_subnets[0].subnet_ids : []
}
output "app_route_table_id" {
  value = length(var.app_subnets_cidr_block) > 0 ? module.app_subnets[0].route_table_id : null
}