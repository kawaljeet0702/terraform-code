#
# DB Subnet Group resources
#

locals { startindex = var.startindex }


resource "aws_db_subnet_group" "private-db-subnetgroup" {
  count       = var.rds_count
  name        = "${lower(var.tags_name)}${var.startindex}-db-sng${count.index}"
  description = "DB Subnet Group for the ${element(var.rds_name, count.index)} RDS Instance"
  subnet_ids  = var.private_subnet_ids

  tags = {
   
  Name                       = "${lower(var.tags_name)}${var.startindex}-db-sng${count.index}"
  Environment                = upper(var.tags_environment)
  Project_Name               = lower(var.tags_project_name)
  tags_department            = var.tags_department
  tags_department_data_owner = var.tags_department_data_owner
    
  }
}

#
# DB Security Group resources
#

module "ec2_sg" {

  source                            = "../../services/ec2-sg"
  enable_sg                         = var.enable_adhoc
  startindex                        = var.sg_startindex
  vpc_id                            = var.vpc_id
  region                            = var.region
  description                       = "${lower(var.tags_name)}${var.startindex}-mssql-sg"
  bastion_sg_id                     = var.bastion_sg_id
  source_sg_id                      = var.source_sg_id
  security_group_id                 = var.security_group_id
  ingress_rules                     = var.ingress_rules
  egress_rules                      = var.egress_rules
  enable_inbound                    = var.enable_inbound
  sg_ingress_rules                  = var.sg_ingress_rules
  misc_from_to_ports_map            = var.misc_from_to_ports_map
  misc_cidr_blocks                  = var.misc_cidr_blocks
  bastion_inbound_from_to_ports_map = var.bastion_inbound_from_to_ports_map
  tags_environment                  = upper(var.tags_environment)
  tags_project                      = lower(var.tags_project_name)
  tags_department                   = var.tags_department
  tags_department_data_owner        = var.tags_department_data_owner
  tags_name                         = "${lower(var.tags_name)}${var.startindex}-mssql-sg"
  }

#
# DB Instance resource
#

data "local_file" "username" {
    filename = var.rds_username
}

data "local_file" "password" {
    filename = var.rds_password
}

resource "aws_db_instance" "rds-instance" {
  count                     = var.rds_count
  allocated_storage         = element(var.rds_allocated_storage, count.index)
  backup_retention_period   = var.rds_backup_retention
  db_subnet_group_name      = lower(aws_db_subnet_group.private-db-subnetgroup[count.index].name)
  engine                    = var.rds_engine
  engine_version            = var.rds_engine_version
  final_snapshot_identifier = "${element(var.rds_name, count.index)}-final-snapshot"
  identifier                = lower(element(var.rds_name, count.index))
  instance_class            = element(var.rds_instance_class, count.index)
  multi_az                  = var.rds_multi_az
  license_model             = var.license_model
  password                  = data.local_file.password.content
  #password                  = var.rds_password
  port                      = var.rds_port
  storage_type              = var.rds_storage_type
  storage_encrypted         = var.rds_storage_encrypted
  kms_key_id                = var.rds_kms_key_id
  skip_final_snapshot       = var.rds_skip_final_snapshot
  #username                  = var.rds_username
  username                  = data.local_file.username.content
  backup_window             = var.rds_preferred_backup_window
  maintenance_window        = var.rds_preferred_maintenance_window
  vpc_security_group_ids    = split(
    ",",
    var.enable_adhoc ? module.ec2_sg.sg_id : var.security_groups,
  )

  tags = {
    Name                       = "${lower(var.tags_name)}${var.startindex}"
    Environment                = upper(var.tags_environment)
    Project_Name               = lower(var.tags_project_name)
    Department                 = var.tags_department
    "Department Data Owner"    = var.tags_department_data_owner
  }

  timeouts {
    create = "60m"
    delete = "60m"
  }
}

