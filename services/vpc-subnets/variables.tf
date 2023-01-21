variable "region" {
}
variable "vpc_id" {
}
variable "subnet_cidr" {
  type = string
}
variable "subnet_az_name" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "route_table_id" {
  type = string
}
#Tags
variable "tags_name" {
  description = "(Mandatory)Used to distinguish between development, test, and production infrastructure"
  type        = string
}

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