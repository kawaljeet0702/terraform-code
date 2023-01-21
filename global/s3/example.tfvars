#general
region       ="us-east-1"

#s3
bucketnames={
"0"="ddsfd"
"1"="fdsfdf3423"
}

versioning_enabled          = true
sse_algorithm               = "aws:kms"
key_arn                     = "arn:aws:kms:us-east-1:xxx:key/xxx"
block_public_policy         = true
block_public_acls           = true
ignore_public_acls          = true
restrict_public_buckets     = true

#lifecycle_rules
#set below to true if you want 30 Standard IA-30 Expire lifecycle
enable_30_30                = true
#set below to true if you want 30 Standard IA lifecycle
enable_30                   = false

#replication configuration (comment the lines as shown below if not required)
replication_configuration = [
        
        {
          account_id                = "xxx"
          replication_role_arn      = "arn:aws:iam::xxx:role/xxx"
          replication_id            = "replication rule"
          replication_bucket_arn    = "arn:aws:s3:::xxx"
          replication_key_arn       = "arn:aws:kms:us-west-2:xxx:key/xxx"
          #set below to "STANDARD_IA" or "STANDARD"
          destination_storage_class = "STANDARD_IA"
        },
        
]

#The override value for the owner on replicated objects. 
#Currently only Destination is supported.
#To leave owner Same as source keep the lines commented as shown below.
access_control_translation = [
        /*{
          owner = "Destination"
        },*/
]


#set below to true if you are planning to attach a policy to the new bucket. Policy file should be placed in "policies" folder
attach_policy               = false
#environment has to be either "dev", "stage" or "prod" 
environment                 = "dev"
policy_filename             = "policy.json"

#s3 force destroy
force_destroy           = true

#tags
tags_environment            ="development"
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"