//
// Module: vpc
//
output "nacls_ids" {
  value = [aws_network_acl.all.*.id]
}
