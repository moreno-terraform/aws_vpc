resource "aws_eip" "nat-ip" {
  count = var.nat_eip_allocation_id == null && length(var.app_subnets_cidr_block) > 0 && length(var.pub_subnets_cidr_block) > 0 ? 1 : 0

  vpc = true
  tags = merge(
    var.tags,
    tomap({
      "Name" = "${var.vpc_name}-nat-eip"
    })
  )
}
locals {
  nat_eip_allocation_id = (var.nat_eip_allocation_id != null
    ? var.nat_eip_allocation_id
    : (length(var.app_subnets_cidr_block) > 0 && length(var.pub_subnets_cidr_block) > 0
      ? aws_eip.nat-ip[0].id
      : null
    )
  )
}
resource "aws_nat_gateway" "nat-gw" {
  count = length(var.app_subnets_cidr_block) > 0 && length(var.pub_subnets_cidr_block) > 0 ? 1 : 0

  depends_on    = [module.pub_subnets]

  allocation_id = local.nat_eip_allocation_id
  subnet_id     = module.pub_subnets[0].subnet_ids[0]

  tags = merge(
    var.tags,
    tomap({
      "Name" = "${var.vpc_name}-nat-gw"
    })
  )
}
resource "aws_route" "nat-route" {
  count = length(var.app_subnets_cidr_block) > 0 && length(var.pub_subnets_cidr_block) > 0 ? length(var.app_nat_dests_cidr_block) : 0

  route_table_id         = module.app_subnets[0].route_table_id
  destination_cidr_block = var.app_nat_dests_cidr_block[count.index]
  nat_gateway_id         = aws_nat_gateway.nat-gw[0].id
}
output "nat_gateway_id" {
  value = (length(var.app_subnets_cidr_block) > 0 && length(var.pub_subnets_cidr_block) > 0
    ? aws_nat_gateway.nat-gw[0].id
    : null
  )
}
output "nat_eip_allocation_id" {
  value = local.nat_eip_allocation_id
}
data "aws_eip" "nat-ip" {
  count = var.nat_eip_allocation_id != null ? 1 : 0
  id = var.nat_eip_allocation_id
}
output "nat_eip_public_ip" {
  value = (var.nat_eip_allocation_id != null
    ? aws_eip.nat-ip[0].public_ip
    : (length(var.app_subnets_cidr_block) > 0 && length(var.pub_subnets_cidr_block) > 0
      ? aws_eip.nat-ip[0].public_ip
      : null
    )
  )
}