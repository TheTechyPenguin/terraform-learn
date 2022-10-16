resource "aws_internet_gateway" "praterra-ig" {
  vpc_id = aws_vpc.praterravpc.id
  tags = {
    "Name" = "${var.project_name}-IG"
    "ENV"  = "${terraform.workspace}"
  }

}