resource "aws_subnet" "praterra-public-subnet" {
  vpc_id                                      = aws_vpc.praterravpc.id
  count                                       = length(slice(data.aws_availability_zones.praterraaz.names, 0, 3))
  cidr_block                                  = cidrsubnet("${var.vpc_cidr}", 8, (count.index) + 1)
  availability_zone                           = data.aws_availability_zones.praterraaz.names[count.index]
  enable_resource_name_dns_a_record_on_launch = true
  map_public_ip_on_launch                     = true
  tags = {
    "Name" = "${var.project_name}-Public_subnet-${count.index + 1}"
    "Env"  = "${terraform.workspace}"
  }
}