//

// Module: ec2

output "instance_ids" {
  value = [aws_instance.instance.*.id]
}

output "private_ips" {
  value = [aws_instance.instance.*.private_ip]
}

output "public_ips" {
  value = [aws_instance.instance.*.public_ip]
}

output "private_dns" {
  value = [aws_instance.instance.*.private_dns]
}

output "count_for_volume_attachments" {
  value = var.serverinfo["extra_volumes"] * var.serverinfo["count"]
}