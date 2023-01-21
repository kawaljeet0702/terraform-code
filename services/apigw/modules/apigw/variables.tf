variable "name" {
  description = "The name of the REST API"
}

variable "description" {
  description = "The description of the REST API"
}

variable "stage" {
  description = "The stage name for the API deployment (production/staging/etc..)"
}

variable "path_part" {
  default = "{proxy+}"
}

variable "authorization" {
  default = "NONE"
}

variable "binary_type" {
  description = "The list of binary media types supported by the RestApi"
  type        = list
  default     = ["*/*"]
}

variable "endpoint_type" {
  type        = list
  default     = ["REGIONAL"]
}


variable "minimum_compression_size" {
  description = "The list of binary media types supported by the RestApi"
  default     = 0
}

variable "lambda_method" {
  description = "The HTTP method"
  default     = "ANY"
}

variable "lambda_arn" {
  description = "The lambda arn"
}

variable "lambda_arn_invoke" {
  description = "The lambda invoke uri"
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