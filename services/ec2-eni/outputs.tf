//
// Module: eni
//

output "eni_id" {
  value = [aws_network_interface.ec2-instance-eni.*.id]
}