variable "region" {
}

variable "key_alias_name" {
}

variable "key_description" {
}

variable "deletion_window_in_days" {
  default=30
}

variable "is_enabled" {
  default=true
}

variable "attach_policy" {
  default=false
}

variable "environment" {
  default="dev"
}

variable "policy_filename" {
  default=""
}

variable "tags" {
    type=map
}