resource "aws_route_table_association" "praterra_rtb_association" {
  count          = length(slice(data.aws_availability_zones.praterraaz.names, 0, 3))
  route_table_id = aws_route_table.praterra-rtb.id
  subnet_id      = element(aws_subnet.praterra-public-subnet.*.id, count.index)



}