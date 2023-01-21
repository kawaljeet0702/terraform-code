#general
region                      ="us-east-1"

key_alias_name              = "my-key-alias"
key_description             = "KMS Key Test"

#Duration in days after which the key is deleted after destruction of the resource 
#must be between 7 and 30 days. Defaults to 30 days.
deletion_window_in_days     = 30

#Specifies whether the key is enabled. Defaults to true.
is_enabled                  = true

#set below to true if you are planning to attach a policy to the new bucket. Policy file should be placed in "policies" folder
attach_policy               = true
#environment has to be either "dev", "stage" or "prod" 
environment                 = "dev"
policy_filename             = "policy.json"

#tags
tags = {
"tags_environment"            ="dev"
"tags_project"                ="project"
"tags_department"             ="dept"
"tags_department_data_owner"  ="owner"
}