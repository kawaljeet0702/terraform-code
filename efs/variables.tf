// Module: sql
variable "efsinfo" {
  type = map(string)
}

variable "aws_profile" {
  default = ""
}

variable "region" {
}

variable "subnet_id" {
}

variable "security_groups" {
}

variable "total_mount_on_each_efs" {
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