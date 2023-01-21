variable "region" {
}

variable "environment" {
  default = "dev"
}

variable "policy_filename" {
  default = ""
}

variable "assume_role_filename" {
  default = ""
}

variable "create_iam_user" {
  default = false
}

variable "create_iam_instance_profile" {
  default = false
}

variable "iam_instance_profile_name" {
  default = ""
}

variable "existing_iam_instance_profile_role" {
  default = ""
}

variable "create_group" {
  default = false
}

variable "create_role" {
  default = false
}

variable "iam_user_name" {
  default = ""
}

variable "group_name" {
  default = ""
}

variable "role_name" {
  default = ""
}

variable "role_description" {
  default = ""
}

variable "create_iam_policy" {
  default = false
}

variable "iam_policy_name" {
  default = ""
}

variable "policy_description" {
  default = ""
}

variable "attach_iam_policy_to_user" {
  default = false
}

variable "user_attachment_name" {
  default = ""
}

variable "exisiting_policy_arn_for_user" {
  default = ""
}

variable "attach_iam_policy_to_role" {
  default = false
}

variable "role_attachment_name" {
  default = ""
}

variable "attach_iam_policy_to_group" {
  default = false
}

variable "group_attachment_name" {
  default = ""
}

variable "exisiting_policy_arn_for_group" {
  default = ""
}

variable "existing_group_names" {
  default = ""
}

variable "existing_user_names" {
  default = ""
}

variable "existing_role_names" {
  default = ""
}

variable "exisiting_policy_arn_for_role" {
  type = list
  default = []
}

variable "attach_multiple_iam_policy_to_role" {
  default = false
}

variable "existing_role_names_for_mutiple_policy_attachment" {
  default = ""
}

variable "role_attachment_name_for_mutiple_policy_attachment" {
  default = ""
}

variable "attach_multiple_iam_policy_to_user" {
  default = false
}

variable "existing_user_names_for_mutiple_policy_attachment" {
  default = ""
}

variable "user_attachment_name_for_mutiple_policy_attachment" {
  default = ""
}

variable "attach_multiple_iam_policy_to_group" {
  default = false
}

variable "existing_group_names_for_mutiple_policy_attachment" {
  default = ""
}

variable "group_attachment_name_for_mutiple_policy_attachment" {
  default = ""
}

/*
variable "exisiting_policy_arn_for_role" {
  default = ""
}
*/