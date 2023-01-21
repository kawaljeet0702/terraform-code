#General
vpc_id                  ="vpc-jhjj4342"

route = [
        {
              destination_cidr_block            = "0.0.0.0/0"
              destination_ipv6_cidr_block       = ""
              destination_prefix_list_id        = ""
              target_carrier_gateway_id         = ""
              target_egress_only_gateway_id     = ""
              target_gateway_id                 = "igw-hgfgh5765"
              target_instance_id                = ""
              target_local_gateway_id           = ""
              target_nat_gateway_id             = ""
              target_network_interface_id       = ""
              target_transit_gateway_id         = ""
              target_vpc_endpoint_id            = ""
              target_vpc_peering_connection_id  = ""
            },
            {
              destination_cidr_block            = "10.0.0.0/8"
              destination_ipv6_cidr_block       = ""
              destination_prefix_list_id        = ""
              target_carrier_gateway_id         = ""
              target_egress_only_gateway_id     = ""
              target_gateway_id                 = "vgw-jkhjkh3242"
              target_instance_id                = ""
              target_local_gateway_id           = ""
              target_nat_gateway_id             = ""
              target_network_interface_id       = ""
              target_transit_gateway_id         = ""
              target_vpc_endpoint_id            = ""
              target_vpc_peering_connection_id  = ""
            },
]



#Tags
tags_environment            ="dev"
tags_name                   ="name"
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"
tags_terraform_managed      ="true"