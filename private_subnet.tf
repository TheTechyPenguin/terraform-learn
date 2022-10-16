resource "aws_subnet" "praterra-private-subnet" {
  count             = length(slice(data.aws_availability_zones.praterraaz.names, 3, 6))
  cidr_block        = cidrsubnet("${var.vpc_cidr}", 8, count.index + 4)
  vpc_id            = aws_vpc.praterravpc.id
  availability_zone = slice(data.aws_availability_zones.praterraaz.names, 3, 6)[count.index]
  tags = {
    "Name" = "${var.project_name}-PrivateSubnet-${count.index + 1}"
    "ENV"  = "${terraform.workspace}"
  }
}