//
// Module: vpc
//
output "subnet_ids" {
  value = [aws_route_table.all.*.id]
}
