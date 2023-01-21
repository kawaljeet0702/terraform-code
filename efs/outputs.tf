//
// Module: eni
//

output "efs_id" {
  value = [aws_efs_file_system.ec2-instance-efs.*.id]
}

output "efs_dns" {
  value = [aws_efs_file_system.ec2-instance-efs.*.dns_name]
}

output "mount_target_dns_name" {
  value = [aws_efs_mount_target.ec2-instance-efs-mount.*.mount_target_dns_name]
}

output "mount_target_ip_address" {
  value = [aws_efs_mount_target.ec2-instance-efs-mount.*.ip_address]
}

output "efs_arn" {
  value = [aws_efs_file_system.ec2-instance-efs.*.arn]
}

output "efs_access_point_arn" {
  value = [aws_efs_access_point.efs_access_point.*.arn]
}