resource "aws_route_table" "all" {
  vpc_id            = var.vpc_id

  dynamic "route" {
    for_each = var.route 
    content{
      cidr_block                 = route.value.destination_cidr_block
      gateway_id                 = route.value.target_gateway_id
      carrier_gateway_id         = route.value.target_carrier_gateway_id
      destination_prefix_list_id = route.value.destination_prefix_list_id
      egress_only_gateway_id     = route.value.target_egress_only_gateway_id
      instance_id                = route.value.target_instance_id
      ipv6_cidr_block            = route.value.destination_ipv6_cidr_block
      local_gateway_id           = route.value.target_local_gateway_id
      nat_gateway_id             = route.value.target_nat_gateway_id
      network_interface_id       = route.value.target_network_interface_id
      transit_gateway_id         = route.value.target_transit_gateway_id
      vpc_endpoint_id            = route.value.target_vpc_endpoint_id
      vpc_peering_connection_id  = route.value.target_vpc_peering_connection_id
     }
  }
  
    tags = {
    Name                      = var.tags_name
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = lower(var.tags_department_data_owner)
    "Terraform Managed"     = "${var.tags_terraform_managed}"
    }
  }