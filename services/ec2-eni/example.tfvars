#General
region          ="us-east-1"
vpc_id          ="vpc-324324"

#Tags
tags_name                   ="name"
tags_environment            ="dev"
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"

eniinfo= {
count=2
startindex=10
}

subnet_id="subnet-42343,subnet-23432423,subnet-3423rrer2"

#Security Group

#Set below to true if you want to create a new security group
enable_adhoc    =false
sg_startindex   =10

#if enable_adhoc is set to false, provide an existing security group to attach to ENI
security_groups="sg-0"

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
        },
]

#Inbound rules with security group as source instead of CIDR blocks
sg_ingress_rules = [
        /*{
          from_port                 = 800
          to_port                   = 8000
          protocol                  = "tcp"
          source_security_group_id  = "sg-34234234"
          description               = "test"
        },
        {
          from_port                 = 20
          to_port                   = 440
          protocol                  = "tcp"
          source_security_group_id  = "sg-32423423fef"
          description               = "test"
        }*/
]

#Add bastion/jump server port and sg-id if any

bastion_inbound_from_to_ports_map ={
  #"22" = "22"
}

bastion_sg_id=""