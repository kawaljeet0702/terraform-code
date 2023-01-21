//
// Module: ec2
locals {
  startindex = var.serverinfo["startindex"]
}

data "template_file" "cfg_user_data" {
  #template = file("userdata/${var.cloud_init}")
  template = file("../../../variables/${var.environment}/services/ec2/userdata/${var.cloud_init}")
  count    = var.serverinfo["count"]
  vars = {
    server_name = lower("${var.tags_name}${count.index + local.startindex}.${var.tags_fqdn}")
  }
}

resource "aws_instance" "instance" {
  ami                     = var.serverinfo["ami"]
  count                   = var.serverinfo["count"]
  instance_type           = element(split(",", var.serverinfo["size"]), count.index)
  key_name                = element(split(",", var.keyname), count.index)
  tenancy                 = var.serverinfo["tenancy"]
  placement_group         = element(split(",", var.placement_group), count.index)
  ebs_optimized           = var.serverinfo["ebs_optimized"]
  disable_api_termination = element(split(",", var.disable_api_termination), count.index)
  monitoring              = element(split(",", var.monitoring), count.index)
  user_data               = data.template_file.cfg_user_data[count.index].rendered
  iam_instance_profile    = aws_iam_instance_profile.ec2_instance_profile.name
  
  
  root_block_device {
    volume_size           = var.serverinfo["root_volume_size"]
    volume_type           = var.serverinfo["root_volume_type"]
    delete_on_termination = true
    kms_key_id            = var.serverinfo["kms_key_id"]
    encrypted             = "true"
  }

  network_interface {
    device_index              = 0
    network_interface_id      = element(split(",", var.eni_id), count.index)
    delete_on_termination     = "false"
  }

  volume_tags = {
    Name                      = lower("${var.tags_name}${count.index + local.startindex}")
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = upper(var.tags_department_data_owner)
    "App Name"                = lower(var.tags_app_name)
  }

  // Cannot interpolate variables for tag keys, see issue #2715. Predefining for now.

  tags = {
    Name                      = lower("${var.tags_name}${count.index + local.startindex}")
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = upper(var.tags_department_data_owner)
    "App Name"                = lower(var.tags_app_name)
  }
  lifecycle {
    ignore_changes = [
      id,
      private_ip,
      tags.Status,
    ]
  }
}

resource "aws_ebs_volume" "volume" {
  count = var.serverinfo["extra_volumes"] * var.serverinfo["count"]
  availability_zone = element(
    aws_instance.instance.*.availability_zone,
    floor(count.index / var.serverinfo["extra_volumes"]),
  )
  size = element(
    split(",", var.serverinfo["extra_volume_sizes"]),
    count.index,
  )
  type = element(
    split(",", var.serverinfo["extra_volume_types"]),
    count.index,
  )
  kms_key_id                  = var.serverinfo["kms_key_id"]
  encrypted                   = "true"

  tags = {
    Name                      = lower("${var.tags_name}${count.index + local.startindex}")
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = upper(var.tags_department_data_owner)
    "App Name"                = lower(var.tags_app_name)
  }

  lifecycle {
    ignore_changes = [availability_zone]
  }
}

resource "aws_volume_attachment" "ebs_att" {
  count       = var.serverinfo["extra_volumes"] * var.serverinfo["count"]
  device_name = element(split(",", var.serverinfo["device_names"]), count.index)
  volume_id   = aws_ebs_volume.volume.*.id[count.index]
  instance_id = element(
    aws_instance.instance.*.id,
    floor(count.index / var.serverinfo["extra_volumes"]),
  )
  force_detach = true

  lifecycle {
    ignore_changes = [
      instance_id,
      volume_id,
    ]
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "ec2-role-${var.tags_name}${local.startindex}"
  #assume_role_policy = file("policies/ec2-role.json")
  assume_role_policy = file("../../../variables/${var.environment}/services/ec2/policies/ec2-role.json")
}

resource "aws_iam_role_policy" "ec2_role_policy" {
  name   = "ec2-instance-profile-${var.tags_name}${local.startindex}"
  #policy = file("policies/ec2-instance-role-policy.json")
  policy = file("../../../variables/${var.environment}/services/ec2/policies/ec2-instance-role-policy.json")
  role   = aws_iam_role.ec2_role.id

  provisioner "local-exec" {
    command = "sleep 40" 
  }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile-${var.tags_name}${local.startindex}"
  path = "/"
  role = aws_iam_role.ec2_role.name

  provisioner "local-exec" {
    command = "sleep 40" 
  }
}