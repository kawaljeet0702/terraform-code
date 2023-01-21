//
// Module: sg
//

variable "vpc_id" {
}

//variable "name" {
//}

variable "description" {
}

//variable "market" {
//}

//variable "environment" {
//}

variable "region" {
}

variable "bastion_sg_id" {
}

variable "source_sg_id" {
  type    = list(string)
  default = []
}

variable "enable_sg" {
  default = false
}

variable "enable_inboundip" {
  default = false
}

variable "enable_inbound" {
  default = false
}

variable "startindex" {
}

variable "sg_cidr_blocks" {
  type    = list(string)
  default = []
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

variable "security_group_id" {
  default = {
    "0" = ""
  }
}

//variable "inbound_from_to_ports_map" {
//  type = map(string)
//}

variable "misc_from_to_ports_map" {
  type    = map(string)
  default = {}
}

variable "misc_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "bastion_inbound_from_to_ports_map" {
  type    = map(string)
  default = {}
}

variable "tags_environment" {
}

variable "tags_name" {
}

variable "tags_project" {
}

variable "tags_department" {
  description = "(Mandatory) Department Name."
  type        = string
}

variable "tags_department_data_owner" {
  description = "(Mandatory) Department Data Owner."
  type        = string
}