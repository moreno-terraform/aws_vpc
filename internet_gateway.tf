resource "aws_internet_gateway" "igw" {
  count = length(var.pub_subnets_cidr_block) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    tomap({
      "Name" = "${var.vpc_name}-igw",
    })
  )
}
resource "aws_route" "igw-route" {
  count = length(var.pub_subnets_cidr_block) > 0 ? length(var.pub_igw_dests_cidr_block) : 0

  route_table_id         = module.pub_subnets[0].route_table_id
  destination_cidr_block = var.pub_igw_dests_cidr_block[count.index]
  gateway_id             = aws_internet_gateway.igw[0].id
}
output "internet_gateway_id" {
  value = (length(var.pub_subnets_cidr_block) > 0
    ? aws_internet_gateway.igw[0].id
    : null
  )
}