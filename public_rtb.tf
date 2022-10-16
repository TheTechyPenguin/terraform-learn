resource "aws_route_table" "praterra-rtb" {
  vpc_id = aws_vpc.praterravpc.id
  route {
    cidr_block = var.public_route_table_cidr_block
    gateway_id = aws_internet_gateway.praterra-ig.id
  }
  tags = {
    "Name" = "${var.project_name}-PublicRTB"
    "Env"  = "${terraform.workspace}"
  }
}