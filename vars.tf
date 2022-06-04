variable "vpc_name" { type = string }
variable "vpc_cidr_block" { type = string }
variable "app_subnet_group_name" {
  type = string
  default = "app"
}
variable "app_subnets_cidr_block" {
  type = list(string)
  default = []
}
variable "nat_eip_allocation_id" {
  type = string
  default = null
}
variable "app_nat_dests_cidr_block" {
  type = list(string)
  default = ["0.0.0.0/0"]
}
variable "priv_subnet_group_name" {
  type = string
  default = "priv"
}
variable "priv_subnets_cidr_block" {
  type = list(string)
  default = []
}
variable "pub_subnet_group_name" {
  type = string
  default = "pub"
}
variable "pub_subnets_cidr_block" {
  type = list(string)
  default = []
}
variable "pub_igw_dests_cidr_block" {
  type = list(string)
  default = ["0.0.0.0/0"]
}
variable "tags" {
  type = map(string)
}