resource "aws_nat_gateway" "praterra-netgateway" {
  allocation_id = aws_eip.praterra-eip.id
  subnet_id     = aws_subnet.praterra-public-subnet.*.id[0]
  tags = {
    "Name" = "${var.project_name}-NGW"
    "ENV"  = "${terraform.workspace}"
  }
}