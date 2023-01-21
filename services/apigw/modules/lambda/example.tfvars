#general
region = "us-east-1"

#tags
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"
#environment has to be either "dev", "stage" or "prod"
tags_environment            ="dev"

#iam_for_lambda
create_iam_role         = false
iam_role_name           = "iam_for_lambda_test"
policy_name             = "test_policy_for_lambda_test"
assume_role_filename    = "assume-role.json"
policy_filename         = "policy.json"

#if create_iam_role is set to false, then please provide arn of an existing iam role for lambda
iam_role            = "arn:aws:iam::xxx:role/xxx"

#lambda
create_lambda_function   = true
function_name            = "lambda_function_name_test"
lambda_description       = "lambda_test"

#lambda version, set below to true in case you want to publish a new version
publish             = false

#s3 payload bucket
s3_bucket           = "xxx"
s3_key              = "lambda_function_payload.zip"
s3_object_version   = "423432553dfdsf"
handler             = "node.js"
runtime             = "nodejs12.x"

#lambda layer
create_lambda_layer = true

#if above is set to true then please provide the lambda layer payload s3 details
lambda_layer_s3_bucket           = "xxx"
lambda_layer_s3_key              = "layer/pandas_xlrd.zip"
lambda_layer_s3_key_version      = ""
layer_name                       = "lambda_layer_name"
lambda_layer_description         = "lambda_layer_test"
compatible_runtimes              = "nodejs12.x"

#if create lambda layer is set to false then please provide arn of the existing layer
#or comment the next line if no layer has to be used
#layer_arns                        = ["arn:aws:lambda:us-east-1:xxx:layer:layer-test:2","arn:aws:lambda:us-east-1:xxx:layer:layer-test:2"]

#reserved_concurrent_executions - (Optional) The amount of reserved concurrent executions for this lambda function. 
#A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. 
#Defaults to Unreserved Concurrency Limits -1
reserved_concurrent_executions = -1

#memory_size in MB
memory_size         = 256

#timeout in seconds
timeout             = 15

environment_variables ={
      "foo" = "bar"
      #"hello" = "world"
}

vpc_config =[
      {
      subnet_ids         = "subnet-09"
      security_group_ids = "sg-04"             
      }
]

#you can send unprocessed events from an asynchronous invocation to an Amazon SQS queue or an Amazon SNS topic.
#enter arn of sns or sqs for target_arn
#comment the lines as 75 to 77 if you are not using any dead_letter_config
dead_letter_config=[
      {
      target_arn          = "arn:aws:sns:us-east-1:xxx:lambda-test"
      }
]

#logs - set 0 to never expire
retention_in_days           =0