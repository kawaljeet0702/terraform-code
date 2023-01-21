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

#ELB Variables
variable "create_applicationlb" {
  default = "false"
}

variable "applicationlb_name" {
  default = ""
}

variable "applicationlb_internal" {
  default = ""
}

variable "applicationlb_subnets" {
  default =[]
}

variable "applicationlb_security_groups" {
  default =[]
}

variable "applicationlb_enable_deletion_protection" {
  default =""
}

variable "applicationlb_access_logs" {
  type = list(object({
      applicationlb_bucket          = string
      applicationlb_bucket_prefix   = string
      applicationlb_enabled         = string
  }))
  default = [
      {
      applicationlb_bucket          = ""
      applicationlb_bucket_prefix   = ""
      applicationlb_enabled         = ""
      }
  ]
}

variable "create_networklb" {
  default = "false"
}

variable "networklb_name" {
  default = ""
}

variable "networklb_internal" {
  default = ""
}

variable "networklb_subnets" {
  default = []
}

variable "networklb_enable_deletion_protection" {
  default = "false"
}

variable "networklb_access_logs" {
  type = list(object({
      networklb_bucket          = string
      networklb_bucket_prefix   = string
      networklb_enabled         = string
  }))
  default = [
      {
      networklb_bucket          = ""
      networklb_bucket_prefix   = ""
      networklb_enabled         = ""
      }
  ]
}

variable "port" {
    type = string
    description = "The port on which targets receive traffic."
}

variable "protocol" {
    type = string
    description = "The protocol to use for routing traffic to the targets."
}

variable "vpc_id" {
    type = string
    description = "The identifier of the VPC in which to create the target group."
}

variable "enable_stickiness" {
    type = string
    description = "If set to Yes, the balancer will attempt to route clients to a consistent back end."
}

variable "health_check_interval" {
    type = string
    description = "The approximate amount of time, in seconds, between health checks of an individual target."
}

variable "health_check_path" {
    type = string
    description = "The destination for the health check request."
}

variable "health_check_protocol" {
    type = string
    description = "The protocol to use to connect with the target."
}

variable "health_check_timeout" {
    type = string
    description = "The amount of time, in seconds, during which no response means a failed health check."
}

variable "health_check_healthy_threshold" {
    type = string
    description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
}

variable "unhealthy_threshold" {
    type = string
    description = "The number of consecutive health check failures required before considering the target unhealthy."
}

variable "matcher" {
    type = string
    description = "The HTTP codes to use when checking for a successful response from a target."
}

variable "name_prefix" {
    type = string
}

variable "ssl_policy" {
    type = string
    description = "The name of the SSL Policy for the listener, e.g. ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "target_id" {
    default = []
}

variable "target_port" {
    type = number
}

variable "target_type" {
    type = string
}

variable "enable_forwardactionlistener" {
    type = bool
}

variable "enable_nlblistener" {
    type = bool
}

variable "alpn_policy" {
    type = string
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