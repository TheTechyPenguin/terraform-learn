output "check_az" {
  value = slice(data.aws_availability_zones.praterraaz.names, 0, 3)

}
output "vpc_id" {
  value = aws_vpc.praterravpc.id

}
output "publicsubetid" {

  value = aws_subnet.praterra-public-subnet.*.id

}
output "PrivateSubnetId" {
  value = aws_subnet.praterra-private-subnet.*.id

}
output "internet-gateway-id" {
  value = aws_internet_gateway.praterra-ig.id

}
output "public-route-table-id" {
  value = aws_route_table.praterra-rtb.id

}
output "Instance-Ip" {
  value = aws_instance.praterraec2.*.public_ip

}