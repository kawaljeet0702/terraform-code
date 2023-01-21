#General{
region        ="us-east-1"
vpc_id        ="vpc-ca"
startindex    =0

private_subnet_ids = [
"subnet-0b",
"subnet-0b06"
]

#Postgres
rds_name = [
"name"
]
rds_count             = 1
rds_allocated_storage = [ 
"1000"
]
rds_backup_retention = 24
rds_engine           = "postgres"
rds_engine_version   = 12.4
rds_instance_class = [ 
"db.m5.xlarge"
]
license_model                    = "postgresql-license"
rds_multi_az                     = "true"
rds_port                         = 5432
rds_storage_type                 = "gp2"
rds_storage_encrypted            = "true"
rds_kms_key_id                   = "arn:aws:kms:us-east-1:xxx:key/xxx"
rds_preferred_maintenance_window = "Mon:00:00-Mon:03:00"
rds_preferred_backup_window      = "03:00-06:00"
sg_startindex                    =0

#use the kubernetes variable name for rds username and password 
rds_username = "USERNAME"
rds_password = "PASSWD"

#Tags
tags_name                   ="name"
tags_environment            ="dev"
tags_project_name           ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"

#if below is set to true, a new security group will be created
#if set to false, please provide an sg-id of an existing security group that you need to attach to the RDS
enable_adhoc  ="true"
security_groups ="sg-02b"

###############################
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
#comment the block as seen below if you do not have any sg-id for inbound rules.
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