variable "region" {
}
variable "vpc_id" {
}

variable "route" {
  type = list(object({
      target_carrier_gateway_id         = string
      destination_cidr_block            = string
      destination_prefix_list_id        = string
      target_egress_only_gateway_id     = string
      target_gateway_id                 = string
      target_instance_id                = string
      destination_ipv6_cidr_block       = string
      target_local_gateway_id           = string
      target_nat_gateway_id             = string
      target_network_interface_id       = string
      target_transit_gateway_id         = string
      target_vpc_endpoint_id            = string
      target_vpc_peering_connection_id  = string
  }))
  default = [
      {
      target_carrier_gateway_id         = ""
      destination_cidr_block            = ""
      destination_prefix_list_id        = ""
      target_egress_only_gateway_id     = ""
      target_gateway_id                 = ""
      target_instance_id                = ""
      destination_ipv6_cidr_block       = ""
      target_local_gateway_id           = ""
      target_nat_gateway_id             = ""
      target_network_interface_id       = ""
      target_transit_gateway_id         = ""
      target_vpc_endpoint_id            = ""
      target_vpc_peering_connection_id  = ""
      }
  ]
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