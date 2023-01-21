locals {
  startindex = var.eniinfo["startindex"]
}

module "ec2_sg" {
  source                            = "../ec2-sg"
  enable_sg                         = var.enable_adhoc
  startindex                        = var.sg_startindex
  vpc_id                            = var.vpc_id
  region                            = var.region
  description                       = lower("${var.tags_name}${local.startindex}-eni-sg")
  bastion_sg_id                     = var.bastion_sg_id
  source_sg_id                      = var.source_sg_id
  security_group_id                 = var.security_group_id
  ingress_rules                     = var.ingress_rules
  egress_rules                      = var.egress_rules
  sg_ingress_rules                  = var.sg_ingress_rules
  misc_from_to_ports_map            = var.misc_from_to_ports_map
  misc_cidr_blocks                  = var.misc_cidr_blocks
  bastion_inbound_from_to_ports_map = var.bastion_inbound_from_to_ports_map
  sg_cidr_blocks                    = var.sg_cidr_blocks
  tags_name                         = lower("${var.tags_name}${local.startindex}-eni-sg")
  tags_environment                  = var.tags_environment
  tags_project                      = var.tags_project
  tags_department                   = var.tags_department
  tags_department_data_owner        = var.tags_department_data_owner
}

resource "aws_network_interface" "ec2-instance-eni" {
  count               = var.eniinfo["count"]
  subnet_id           = element(split(",", var.subnet_id), count.index)
  security_groups     = split(
    ",",
    var.enable_adhoc ? module.ec2_sg.sg_id : var.security_groups,
  )
  tags = {
    Name                      = lower("${var.tags_name}${count.index + local.startindex}-eni")
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = lower(var.tags_department_data_owner)
  }
}
