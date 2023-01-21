// Module: sql
variable "subnet_id" {
}

variable "eniinfo" {
  type = map(string)
}

variable "aws_profile" {
  default = ""
}

variable "enable_adhoc" {
  default = false
}

variable "app_name" {
  default = "ec2"
}

variable "security_groups" {
  default = "sg-4"
}

variable "associate_public_ip_address" {
  default = false
}

variable "region" {
}

variable "inbound_from_to_ports_map" {
  type    = map(string)
  default = {}
}

variable "misc_from_to_ports_map" {
  type    = map(string)
  default = {}
}

variable "bastion_inbound_from_to_ports_map" {
  type    = map(string)
  default = {}
}

variable "sg_cidr_blocks" {
  type = list(string)

  default = [
    "100.64.0.0/16",
    "142.11.128.0/24",
    "10.135.0.0/16",
    "10.0.0.0/14",
  ]
}

variable "misc_cidr_blocks" {
  type = list(string)

  default = []
}

variable "sg_startindex" {
  default = 0
}

variable "vpc_id" {
  default = "vpc-9"
}

variable "mgmt_sg_id" {
  default = "sg-94"
}

variable "bastion_sg_id" {
  default = "sg-d"
}

variable "source_sg_id" {
  type = list(string)
  default = [
    "sg-07",
  ]
}

variable "security_group_id" {
  default = {
    "0" = "sg-f7"
    "1" = "sg-e6"
  }
}

variable "market" {
  default = "Market"
}

variable "environment" {
  default = "env"
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

#Tags
variable "tags_environment" {
  description = "(Mandatory)Used to distinguish between development, test, and production infrastructure"
  type        = string
}

variable "tags_name" {
  description = "(Mandatory)A cosmetic, compound tag used to help identify, sort, group, and troubleshoot resources in AWS consoles,etc. and <region using>-<short environment name>-<short app name>-<short app tier>)."
  type        = string
}

variable "tags_project" {
  description = "(Optional)Used to identify the project(s) the resource supports."
  type        = string
  default     = "undefined"
}

variable "tags_department" {
  description = "(Mandatory) Department Name."
  type        = string
}

variable "tags_department_data_owner" {
  description = "(Mandatory) Department Data Owner."
  type        = string
}