variable "vpc_id" {
}

variable "region" {
}

# RDS
variable "rds_aurora_instance_count" {
  default = "2"
}

variable "rds_backup_retention_period" {
  default = "5"
}

variable "rds_skip_final_snapshot" {
  default = "true"
}

variable "rds_storage_encrypted" {
  default = "true"
}

variable "rds_kms_key_id" {
  default = ""
}

variable "rds_backup_retention" {
  default = "7"
}

variable "rds_allocated_storage" {
  type = list(string)
}

variable "rds_engine" {
}

variable "rds_engine_version" {
}

variable "rds_multi_az" {
}

variable "rds_mysql_family_pg" {
  default = "mysql5.7"
}

variable "rds_instance_class" {
  type = list(string)
}

variable "rds_name" {
  type = list(string)
}

variable "rds_count" {
}

variable "private_subnet_ids" {
}

variable "rds_storage_type" {
}


variable "rds_password" {
}


variable "rds_port" {
}

variable "rds_username" {
}

variable "rds_preferred_maintenance_window" {
  default = "sat:12:00-sat:15:59"
}

variable "rds_preferred_backup_window" {
  default = "20:00-23:59"
}

# TAGS
variable "tags_environment" {
}

variable "tags_name" {
}

variable "tags_project_name" {
}

variable "license_model" {
}

variable "tags_department_data_owner" {
}

variable "tags_department" {
}

variable "startindex" {
}

###SG

variable "enable_adhoc" {
  default = false
}

variable "app_name" {
  default = "rds"
}

variable "security_groups" {
  default = "sg-06b"
}

variable "misc_cidr_blocks" {
  type = list(string)

  default = []
}

variable "bastion_inbound_from_to_ports_map" {
  type    = map(string)
  default = {}
}

variable "bastion_sg_id" {
  default = ""
}

variable "source_sg_id" {
  type = list(string)
  default = [
    "sg-0e27",
  ]
}

variable "misc_from_to_ports_map" {
  type    = map(string)
  default = {}
}

variable "security_group_id" {
  default = {
    "0" = ""
    "1" = ""
  }
}

variable "sg_startindex" {
  default = 0
}

variable "inbound_from_to_ports_map" {
  type    = map(string)
  default = {}
}

variable "test" {
  default = false
}

  variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks  = string
      description = string
    }))
}

variable "egress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks  = string
      description = string
    }))
}

variable "sg_ingress_rules" {
    type = list(object({
      from_port                 = number
      to_port                   = number
      protocol                  = string
      source_security_group_id  = string
      description               = string
    }))
}

variable "enable_inbound" {
  default = false
}