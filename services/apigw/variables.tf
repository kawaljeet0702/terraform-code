####################
# Tags
####################
variable "project" {
  description = "Project name for tags and resource naming"
}

variable "environment" {
  description = "The stage name(production/staging/etc..)"
}

variable "region" {
  description = "The AWS region, e.g., eu-west-1"
}


####################
# API Gateway
####################
variable "binary_type" {
  description = "The list of binary media types supported by the RestApi"
  type        = list
  default     = ["*/*"]
}

variable "minimum_compression_size" {
  description = "The minimum response size to compress for the REST API"
  default     = 0
}

variable "lambda_method" {
  description = "The HTTP method for the REST API"
  default     = "ANY"
}

variable "apigw_name" {
}

variable "description" {
  default = ""
}

variable "endpoint_type" {
  type        = list
  default     = ["REGIONAL"]
}

variable "path_part" {
  default = "{proxy+}"
}

variable "authorization" {
  default = "NONE"
}

variable "metrics_enabled" {
  default = true
}

variable "logging_level" {
  default = "INFO"
}

variable "throttling_burst_limit" {
  default = "1000"
}

variable "throttling_rate_limit" {
  default = "5000"
}

variable "caching_enabled" {
  default = true
}

variable "cache_data_encrypted" {
  default = true
}

variable "cache_ttl_in_seconds" {
  default = "300"
}

variable "rest_api_policy_filename" {
  default = ""
}

####################
# Lambda
####################
variable "create_iam_role" {
  default = false
}

variable "create_lambda_function" {
  default = true
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

#Lambda tags
variable "tags_project" {
}

variable "tags_department" {
}

variable "tags_department_data_owner" {
}