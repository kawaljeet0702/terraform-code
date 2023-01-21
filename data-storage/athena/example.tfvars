#general
region       ="us-east-1"

#athena_db
create_db               = true
database_name           = "test_database_name"

#athena_workgroup
create_workgroup        = true
workgroup_name          = "test_workgroup_name"
workgroup_description   = "test_workgroup_name_description"

#named query
#provide db and workgroup names if create_db or create_workgroup are set to false
create_query            = true
query_name              = "bar"
existing_db_name        = ""
exisiting_workgroup_name= ""
query                   = "SELECT * FROM test_database_name limit 10;"

#s3
create_s3               = true

#if above is set to false then please provide an existing bucket arn
bucket_arn              =""

bucketname={
"0"="sdfsd32345456df3454435sdgf"
}

versioning_enabled      = true
sse_algorithm           = "aws:kms"
key_arn                 = "arn:aws:kms:us-east-1:xxx:key/xxx"
block_public_policy     = true
block_public_acls       = true
ignore_public_acls      = true
restrict_public_buckets = true

#lifecycle_rules
#set below to true if you want 30 Standard IA-30 Expire lifecycle
enable_30_30            = true
#set below to true if you want 30 Standard IA lifecycle
enable_30               = false

#replication configuration (comment the lines as shown below if not required)
replication_configuration = [
        /*
        {
          replication_role_arn      = "arn:aws:iam::xxx:role/xxx"
          replication_id            = "replication rule"
          replication_bucket_arn    = "arn:aws:s3:::xxx"
          #set below to "STANDARD_IA" or "STANDARD"
          destination_storage_class = "STANDARD_IA"
        },
        */
]

#set below to true if you are planning to attach a policy to the new bucket. Policy file should be placed in "policies" folder
attach_policy           = false
#environment has to be either "dev", "stage" or "prod" 
environment             = "dev"
policy_filename         = "policy.json"

#s3 force destroy
force_destroy           = true

#tags
tags_environment            ="dev"
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"