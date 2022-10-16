resource "aws_route_table_association" "praterra-private-rtb-association" {
  count          = length(slice(data.aws_availability_zones.praterraaz.names, 3, 6))
  route_table_id = aws_route_table.Private_Route_Table.id
  subnet_id      = element(aws_subnet.praterra-private-subnet.*.id, count.index)

}