variable "region" {
}

variable "environment" {
  default = "dev"
}

variable "create_iam_role" {
  default = false
}

variable "create_endpoint" {
  default = false
}

variable "endpoint_name" {
  default = ""
}

variable "endpoint_config_name" {
  default = ""
}

variable "create_endpoint_configuration" {
  default = false
}

variable "create_model" {
  default = false
}

variable "create_notebook_instance" {
  default = false
}

variable "role_arn" {
  default = ""
}

variable "ec_name" {
  default = ""
}

variable "variant_name" {
  default = ""
}

variable "model_name" {
  default = ""
}

variable "ec_model_name" {
  default = ""
}

variable "initial_instance_count" {
  default = ""
}

variable "initial_variant_weight" {
  default = ""
}

variable "ec_instance_type" {
  default = ""
}

variable "policy_name" {
  default = ""
}

variable "policy_filename" {
  default = ""
}

variable "iam_role_name" {
  default = ""
}

variable "assume_role_filename" {
  default = ""
}

variable "sagemaker_instance_name" {
  description = "The name of the new instance."
}

variable "sagemaker_instance_type" {
  description = "The instance type of the new notebook."
}

variable "root_access" {
  default = "Enabled"
}

variable "volume_size" {
  default = 5
}

variable "default_code_repository" {
  default = ""
}

variable "primary_container" {
    type = list(object({
      image           = string
      mode            = string
      model_data_url  = string
    }))
}

variable "tags" {
  description = "A mapping of tags to assign to the SageMaker Model."
  type        = map(string)
  default     = {}
}
