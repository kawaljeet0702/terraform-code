#api gateway
module "api" {
  source                   = "./modules/apigw"
  name                     = var.apigw_name
  description              = var.description
  stage                    = var.environment
  lambda_method            = var.lambda_method
  binary_type              = var.binary_type
  endpoint_type            = var.endpoint_type
  path_part                = var.path_part
  authorization            = var.authorization
  minimum_compression_size = var.minimum_compression_size
  lambda_arn               = module.lambda.arn
  lambda_arn_invoke        = module.lambda.arn_invoke
  metrics_enabled          = var.metrics_enabled
  logging_level            = var.logging_level
  throttling_burst_limit   = var.throttling_burst_limit
  throttling_rate_limit    = var.throttling_rate_limit
  caching_enabled          = var.caching_enabled
  cache_data_encrypted     = var.cache_data_encrypted
  cache_ttl_in_seconds     = var.cache_ttl_in_seconds
  rest_api_policy_filename = var.rest_api_policy_filename
}


#lambda
module "lambda" {
  source                           = "./modules/lambda"
  region                           = var.region
  tags_project                     = var.tags_project
  tags_department                  = var.tags_department
  tags_department_data_owner       = var.tags_department_data_owner
  tags_environment                 = var.environment
  create_iam_role                  = var.create_iam_role
  iam_role_name                    = var.iam_role_name
  policy_name                      = var.policy_name
  lambda_assume_role_filename      = var.lambda_assume_role_filename
  lambda_policy_filename           = var.lambda_policy_filename
  iam_role                         = var.iam_role
  create_lambda_function           = var.create_lambda_function
  function_name                    = var.function_name
  lambda_description               = var.lambda_description
  publish                          = var.publish
  s3_bucket                        = var.s3_bucket
  s3_key                           = var.s3_key
  s3_object_version                = var.s3_object_version
  handler                          = var.handler
  runtime                          = var.runtime
  create_lambda_layer              = var.create_lambda_layer
  lambda_layer_s3_bucket           = var.lambda_layer_s3_bucket
  lambda_layer_s3_key              = var.lambda_layer_s3_key
  lambda_layer_s3_key_version      = var.lambda_layer_s3_key_version
  layer_name                       = var.layer_name
  lambda_layer_description         = var.lambda_layer_description
  compatible_runtimes              = var.compatible_runtimes
  layer_arns                       = var.layer_arns
  reserved_concurrent_executions   = var.reserved_concurrent_executions
  memory_size                      = var.memory_size
  timeout                          = var.timeout
  environment_variables            = var.environment_variables
  vpc_config                       = var.vpc_config
  dead_letter_config               = var.dead_letter_config
  retention_in_days                = var.retention_in_days
}