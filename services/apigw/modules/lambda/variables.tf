variable "region" {
}

variable "create_iam_role" {
  default = false
}

variable "create_lambda_function" {
  default = false
}

variable "iam_role" {
  default = ""
}

variable "iam_role_name" {
  default = ""
}

variable "lambda_policy_filename" {
  default = ""
}

variable "lambda_assume_role_filename" {
  default = ""
}

variable "lambda_description" {
  default = ""
}

variable "lambda_layer_description" {
  default = ""
}

variable "policy_name" {
  default = ""
}

variable "s3_bucket" {
  default = ""
}

variable "s3_key" {
  default = ""
}

variable "s3_object_version" {
  default = ""
}

variable "payload_filename" {
  default = ""
}

variable "function_name" {
}

variable "publish" {
  default = false
}

variable "handler" {
  default = ""
}

variable "runtime" {
  default = ""
}

variable "create_lambda_layer" {
  default = false
}

variable "lambda_layer_s3_bucket" {
  default = ""
}

variable "lambda_layer_s3_key" {
  default = ""
}

variable "layer_name" {
  default = ""
}

variable "compatible_runtimes" {
  default = ""
}

variable "layer_arns" {
  type = list
  default = []
}

variable "memory_size" {
  default = 128
}

variable "timeout" {
  default = 3
}

variable "reserved_concurrent_executions" {
  default = -1
}

variable "retention_in_days" {
  default = 14
}

variable "environment_variables" {
  type    = map(string)
  default = null
}

variable "vpc_config" {
    type = list(object({
      subnet_ids          = string
      security_group_ids  = string
    }))
}

variable "dead_letter_config" {
    type = list(object({
      target_arn          = string
    }))
}

variable "lambda_layer_s3_key_version" {
  default = ""
}

#tags
variable "tags_environment" {
}

variable "tags_project" {
}

variable "tags_department" {
}

variable "tags_department_data_owner" {
}