resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false

  tags = merge(
    var.tags,
    tomap({
      "Name" = "${var.vpc_name}"
    })
  )
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}