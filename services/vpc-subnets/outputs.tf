//
// Module: vpc
//
output "subnet_ids" {
  value = [aws_subnet.all.*.id]
}
