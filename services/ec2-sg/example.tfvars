#General
region      ="us-east-1"
vpc_id      ="vpc-7a"
description ="test security group"
enable_sg   =true

startindex  =0

#Tags
tags_name                   ="name"
tags_environment            ="dev"
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"

#Security group rules

#Inbound rules
ingress_rules = [
        {
          from_port   = 800
          to_port     = 8000
          protocol    = "tcp"
          cidr_blocks = "1.2.0.0/16"
          description = "test"
        },
        {
          from_port   = 230
          to_port     = 2300
          protocol    = "tcp"
          cidr_blocks = "1.2.3.4/32"
          description = "test"
        },
]

#Outbound rules
egress_rules = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = "1.2.0.0/16"
          description = "test"
        },
        {
          from_port   = 23
          to_port     = 23
          protocol    = "tcp"
          cidr_blocks = "1.2.3.4/32"
          description = "test"
        }
]

#Inbound rules with security group as source instead of CIDR blocks
sg_ingress_rules = [
        /*{
          from_port                 = 800
          to_port                   = 8000
          protocol                  = "tcp"
          source_security_group_id  = "sg-0319cf1d7e1953d2b"
          description               = "test"
        },
        {
          from_port                 = 20
          to_port                   = 440
          protocol                  = "tcp"
          source_security_group_id  = "sg-0319cf1d7e1953d2b"
          description               = "test"
        }*/
]

#Add bastion/jump server port and sg-id if any

bastion_inbound_from_to_ports_map ={
  #"22" = "22"
}

bastion_sg_id=""