module "priv_subnets" {
  count = length(var.priv_subnets_cidr_block) > 0 ? 1 : 0

  source = "git::https://github.com/moreno-terraform/aws_subnets.git?ref=1.0"

  vpc_id = aws_vpc.vpc.id
  vpc_name = var.vpc_name
  subnet_group_name = var.priv_subnet_group_name
  subnets_cidr_block = var.priv_subnets_cidr_block
  map_public_ip_on_launch = false
  tags = var.tags
}
output "priv_subnet_ids" {
  value = length(var.priv_subnets_cidr_block) > 0 ? module.priv_subnets[0].subnet_ids : []
}
output "priv_route_table_id" {
  value = length(var.priv_subnets_cidr_block) > 0 ? module.priv_subnets[0].route_table_id : null
}