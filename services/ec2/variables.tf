// Module: sql

variable "environment" {
  default = "dev"
}

variable "eni_id" {
  default = ""
}

variable "cloud_init" {
  #default = ""
}

variable "keyname" {
}

variable "private_ip" {
  default = ""
}

variable "iam_instance_profile" {
  default = ""
}

variable "aws_profile" {
  default = ""
}

variable "monitoring" {
  default = true
}

variable "user_data" {
  default = ""
}

variable "placement_group" {
  default = ""
}

variable "region" {
}

variable "disable_api_termination" {
  default = false
}

variable "serverinfo" {
  type = map(string)
}

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

variable "tags_fqdn" {
  description = "(Mandatory) FQDN."
  type        = string
}

variable "tags_app_name" {
  description = "(Mandatory) Application Name."
  type        = string
}