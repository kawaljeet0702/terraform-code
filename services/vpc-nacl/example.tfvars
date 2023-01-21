#General
region = "us-east-1"
vpc_id = "vpc-dfsdf3423"

subnet_id = ["subnet-34234dsfds","subnet-dfsfsd23423","subnet-dfsdf23423"]

#NACLs
# 
ingress_nacls = {
  #example-rule  = [ rule_no, protocol, action, cidr_block, from_port, to_port ]
}

egress_nacls = {
  #example-rule  = [ rule_no, protocol, action, cidr_block, from_port, to_port ]

}

#Tags
tags_name="name"
tags_environment="dev"
tags_project="project"
tags_department="dept"
tags_department_data_owner="owner"
tags_terraform_managed="True"
