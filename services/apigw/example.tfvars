#General
region            ="us-east-1"
#environment has to be either "dev", "stage" or "prod"
environment       ="dev"
project           ="wav-test-1"

####################
# API Gateway
####################
apigw_name        ="api_name_test"
description       ="API Description Test"
#API GW path part
path_part         = "{proxy+}"
#he minimum response size to compress for the REST API
minimum_compression_size=0
#The list of binary media types supported by the RestApi
binary_type       = ["*/*"]
endpoint_type     = ["REGIONAL"]


#The HTTP method for the REST API
lambda_method            = "POST"
#apigw request method authorization
authorization            = "NONE"
metrics_enabled          = true
logging_level            = "INFO"
throttling_burst_limit   = "1000"
throttling_rate_limit    = "5000"
caching_enabled          = true
cache_data_encrypted     = true 
cache_ttl_in_seconds     = "300"

rest_api_policy_filename = "rest-api-policy.json"


####################
# Lambda
####################
#lambda_tags
tags_project                ="HDP"
tags_department             ="Hyatt Data Analytics and Insights"
tags_department_data_owner  ="Raymond Boyle"


#iam_for_lambda
create_iam_role                = true
iam_role_name                  = "iam_for_lambda_test_2"
policy_name                    = "test_policy_for_lambda_test_2"
lambda_assume_role_filename    = "lambda-assume-role.json"
lambda_policy_filename         = "lambda-policy.json"

#if create_iam_role is set to false, then please provide arn of an existing iam role for lambda
iam_role            = "arn:aws:iam::354156725301:role/lambda-test"

#lambda
function_name            = "lambda_function_name_test"
lambda_description       = "lambda_test"

#lambda version, set below to true in case you want to publish a new version
publish             = false

#s3 payload bucket
s3_bucket           = "h-lambda-dev-payloads"
s3_key              = "lambda_function_payload.zip"
s3_object_version   = "XTwzrGhNVIgPcsIJK_WdosI9Mi2deau4"

#expected runtime to be one of [nodejs nodejs4.3 nodejs6.10 nodejs8.10 nodejs10.x nodejs12.x java8 java8.al2 java11 python2.7 python3.6 python3.7 
#python3.8 dotnetcore1.0 dotnetcore2.0 dotnetcore2.1 dotnetcore3.1 nodejs4.3-edge go1.x ruby2.5 ruby2.7 provided provided.al2
handler             = "node.js"
runtime             = "nodejs12.x"

#lambda layer
create_lambda_layer = true

#if above is set to true then please provide the lambda layer payload s3 details
lambda_layer_s3_bucket           = "h-lambda-dev-payloads"
lambda_layer_s3_key              = "layer/pandas_xlrd.zip"
lambda_layer_s3_key_version      = ""
layer_name                       = "lambda_layer_name"
lambda_layer_description         = "lambda_layer_test"
compatible_runtimes              = "nodejs12.x"

#if create lambda layer is set to false then please provide arn of the existing layer
#or comment the next line if no layer has to be used
#layer_arns                        = ["arn:aws:lambda:us-east-1:354156725301:layer:layer-test:2","arn:aws:lambda:us-east-1:354156725301:layer:layer-test:2"]

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
      subnet_ids         = "subnet-0b063b36576bb8ce9"
      security_group_ids = "sg-04c5a9be9767ee83f"             
      }
]

#you can send unprocessed events from an asynchronous invocation to an Amazon SQS queue or an Amazon SNS topic.
#enter arn of sns or sqs for target_arn
#comment the lines as 75 to 77 if you are not using any dead_letter_config
dead_letter_config=[
      {
      target_arn          = "arn:aws:sns:us-east-1:354156725301:lambda-test"
      }
]

#logs - set 0 to never expire
retention_in_days           =0