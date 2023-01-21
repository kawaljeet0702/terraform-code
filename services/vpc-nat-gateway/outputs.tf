//
// Module: vpc
//

output "aws_eip_id" {
  value = [aws_eip.nat.id]
}
output "aws_eip_public_ip" {
  value = [aws_eip.nat.public_ip]
}
output "aws_eip_private_ip" {
  value = [aws_eip.nat.private_ip]
}
output "nat_gw_ids" {
  value = [aws_nat_gateway.all.id]
}

output "nat_gw_public_ip" {
  value = [aws_nat_gateway.all.public_ip] 
}
output "nat_gw_private_ip" {
  value = [aws_nat_gateway.all.private_ip] 
}