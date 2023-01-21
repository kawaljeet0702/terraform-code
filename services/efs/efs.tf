locals {
  startindex = var.efsinfo["startindex"]
}

resource "aws_efs_file_system" "ec2-instance-efs" {
  creation_token    = "${var.tags_name}${local.startindex}"
  performance_mode  = var.efsinfo["performance_mode"]
  throughput_mode   = var.efsinfo["throughput_mode"]
  encrypted         = var.efsinfo["encrypted"]
  kms_key_id        = var.efsinfo["kms_key_id"]
  lifecycle_policy {
    transition_to_ia            = var.efsinfo["transition_to_ia"]
    }

  tags = {
    Name                      = lower("${var.tags_name}${local.startindex}")
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = lower(var.tags_department_data_owner)
  }
}

resource "aws_efs_mount_target" "ec2-instance-efs-mount" {
   count            = length(split(",", var.subnet_id))
   file_system_id   = element(aws_efs_file_system.ec2-instance-efs.*.id, 0)
   subnet_id        = element(split(",", var.subnet_id), count.index)
   security_groups  = [element(split(",", var.security_groups), count.index)]
}

resource "aws_efs_access_point" "efs_access_point" {
   file_system_id   = element(aws_efs_file_system.ec2-instance-efs.*.id, 0)
   posix_user {
     gid = var.efsinfo["owner_gid"]
     uid = var.efsinfo["owner_uid"]
   }
   root_directory {
     path = var.efsinfo["root_directory_path"]
     creation_info {
       owner_gid = var.efsinfo["owner_gid"]
       owner_uid = var.efsinfo["owner_uid"]
       permissions = var.efsinfo["root_directory_perms"]
     }
   }
   tags = {
    Name                      = lower("${var.tags_name}${local.startindex}")
   }
}
