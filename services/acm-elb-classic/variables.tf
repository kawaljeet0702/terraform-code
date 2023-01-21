// Module: ACM
variable "region" {
  
}
variable "certificate_domain_name" {
  description = "(Mandatory)Provide Domain Name for the Certificate Request."
  type        = string
}
variable "validation_method" {
  description = "(Mandatory)Provide validation method."
  type        = string
}

variable "public_zone_name" {
  description = "(Mandatory)Route53 Public Zone used with Certificate."
  type        = string
}

# ELB Variables.
variable "listener" {
}

variable "elb_name" {
}

variable "subnets" {
}

variable "security_groups" {
}

variable "listener_with_certificate" {
  type = list(object({
      instance_port      = number
      instance_protocol  = string
      lb_port            = number
      lb_protocol        = string
  }))
  default = [
      {
      instance_port      = -1
      instance_protocol  = ""
      lb_port            = -1
      lb_protocol        = ""
      }
  ]
}

variable "access_logs" {
  type = list(object({
      bucket          = string
      bucket_prefix   = string
      interval        = number
  }))
  default = [
      {
      bucket          = ""
      bucket_prefix   = ""
      interval        = -1
      }
  ]
}

variable "health_check" {
  type = list(object({
      healthy_threshold     = number
      unhealthy_threshold   = number
      timeout               = number
      target                = string
      interval              = number
  }))
  default = [
      {
      healthy_threshold     = -1
      unhealthy_threshold   = -1
      timeout               = -1
      target                = ""
      interval              = -1
      }
  ]
}

variable "instances" {
  default = []
}

variable "cross_zone_load_balancing" {
  default = ""
}

variable "idle_timeout" {
  default = ""
}

variable "connection_draining" {
  default = ""
}

variable "connection_draining_timeout" {
  default = ""
}

#Tags

variable "tags_environment" {
  description = "(Mandatory)Used to distinguish between development, test, and production infrastructure"
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

variable "tags_terraform_managed" {
  description = "(Mandatory) Managed by terraform."
  type        = string
}