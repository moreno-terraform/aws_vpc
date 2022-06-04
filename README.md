# AWS VPC Module

This module can be used to generate AWS VPC using Terraform.

# Use

```terraform
locals {
  tags = {
    "Owner"       = "Put Your Name here"
    "Account"     = "YourAccountName"
    "Environment" = "YourEnvironmentName"
    "Iac"         = "Terraform"
    "Product"     = "Example"
  }
  vpc_name = "example"
  vpc_cidr_block = "10.100.0.0/16"
  app_subnets_cidr_block = ["10.100.0.0/20", "10.100.16.0/20", "10.100.32.0/20", "10.100.48.0/20"]
  pub_subnets_cidr_block = ["10.100.200.0/22", "10.100.204.0/22"]
}
module "vpc" {
  source = "git::https://github.com/moreno-terraform/aws_vpc.git"
  vpc_name = local.vpc_name
  vpc_cidr_block = local.vpc_cidr_block
  app_subnets_cidr_block = local.app_subnets_cidr_block
  pub_subnets_cidr_block = local.pub_subnets_cidr_block
  tags = local.tags
}
```

# Arguments

* `vpc_name` - (Required) VPC name. It is used to define resources names in this module.

* `vpc_cidr_block` - (Required) a cidr block used to create VPC.

* `app_subnet_group_name` - (Optional) app subnet group name, that is used with `vpc_name` to define resources names in this module to subnets app. The default value is `"app"`.

* `app_subnets_cidr_block` - (Optional) list of cidr blocks used to create app subnets, it is used available zones in the region, if the list of cidr blocks length is greater than available zones length, then some subnets will be in the same aws zone.

* `nat_eip_allocation_id` - (Optional) allocation ID of AWS Elastic IP, it can be used to define EIP outside of this module.

* `app_nat_dests_cidr_block` - (Optional) list of cidr blocks used as destination the nat gateway. The default value is `["0.0.0.0/0"]`.

* `priv_subnet_group_name` - (Optional) private subnet group name, that is used with `vpc_name` to define resources names in this module to subnets private. The default value is `"priv"`.

* `priv_subnets_cidr_block` - (Optional) list of cidr blocks used to create private subnets, it is used available zones in the region, if the list of cidr blocks length is greater than available zones length, then some subnets will be in the same aws zone.

* `pub_subnet_group_name` - (Optional) public subnet group name, that is used with `vpc_name` to define resources names in this module to subnets public. The default value is `"pub"`.

* `pub_subnets_cidr_block` - (Optional) list of cidr blocks used to create public subnets, it is used available zones in the region, if the list of cidr blocks length is greater than available zones length, then some subnets will be in the same aws zone.

* `pub_igw_dests_cidr_block` - (Optional) list of cidr blocks used as destination the internet gateway. The default value is `["0.0.0.0/0"]`.

* `tags` - (Optional) string map with the tags to put on resources created in this module.

# Outputs

* `vpc_id` - VPC ID.

* `vpc_name` - VPC name, the same got in the arguments.

* `app_route_table_id` - aws route table ID of the app subnets.

* `app_subnet_ids` - aws subnet IDs of the app subnets.

* `priv_route_table_id` - aws route table ID of the private subnets.

* `priv_subnet_ids` - aws subnet IDs of the private subnets.

* `pub_route_table_id` - aws route table ID of the public subnets.

* `pub_subnet_ids` - aws subnet IDs of the public subnets.

* `nat_gateway_id` - aws nat gateway ID used on app subnets.

* `nat_eip_allocation_id` - allocation ID of AWS Elastic IP of the nat gateway.

* `nat_eip_public_ip` - nat gateway public IP.

* `internet_gateway_id` - aws internet gateway ID used on pub subnets