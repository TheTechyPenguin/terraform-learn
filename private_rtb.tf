resource "aws_route_table" "Private_Route_Table" {
  vpc_id = aws_vpc.praterravpc.id
  route {
    cidr_block = var.private_route_table_cidr_block
    gateway_id = aws_nat_gateway.praterra-netgateway.id
  }
  tags = {
    "Name" = "${var.project_name}--PrivateRTB"
    "Env"  = "${terraform.workspace}"
  }
}