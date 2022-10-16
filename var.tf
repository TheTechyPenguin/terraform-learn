variable "aws_region" {}
variable "access_key" {}
variable "secret_key" {}
variable "vpc_cidr" {}
variable "project_name" {}
variable "public_route_table_cidr_block" {}
variable "private_route_table_cidr_block" {}
variable "ec2_sg_decsription" {}
variable "sg_from_port_http" {}
variable "sg_to_port_http" {}
variable "sg_to_port_ssh" {}
variable "sg_from_port_ssh" {}
variable "sg_cidr_block" {}
variable "sg_protocol" {}
variable "instnce_count" {}
variable "instance_type" {
  type = map(string)
  default = {
    "production" = "t3.medium"
    "staging"    = "t2.micro"
  }

}
variable "key_pair_path" {}