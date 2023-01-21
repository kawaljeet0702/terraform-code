locals {
  environment_map = var.environment_variables[*]
}

resource "aws_lambda_layer_version" "lambda_layer" {
  count             = var.create_lambda_layer ? 1 : 0
  s3_bucket         = var.lambda_layer_s3_bucket
  s3_key            = var.lambda_layer_s3_key
  s3_object_version = var.lambda_layer_s3_key_version  
  layer_name        = var.layer_name
  description       = var.lambda_layer_description

  compatible_runtimes = [var.compatible_runtimes]
}

resource "aws_iam_role_policy" "policy" {
  count = var.create_iam_role ? 1 : 0
  name = var.policy_name
  role = aws_iam_role.iam_for_lambda[0].id
  policy = file("../../../variables/${var.tags_environment}/services/apigw/policies/${var.lambda_policy_filename}")
  #policy = file("policies/${var.lambda_policy_filename}")
}

resource "aws_iam_role" "iam_for_lambda" {
  count = var.create_iam_role ? 1 : 0
  name = var.iam_role_name
  assume_role_policy = file("../../../variables/${var.tags_environment}/services/apigw/policies/${var.lambda_assume_role_filename}")
  #assume_role_policy = file("policies/${var.lambda_assume_role_filename}")
}

resource "aws_cloudwatch_log_group" "log_for_lambda" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.retention_in_days
}

resource "aws_lambda_function" "lambda" {
  count             = var.create_lambda_function ? 1 : 0
  #filename      = "payload/${var.payload_filename}"
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version
  function_name     = var.function_name
  role              = var.create_iam_role ? aws_iam_role.iam_for_lambda[0].arn : var.iam_role
  handler           = var.handler
  layers            = var.create_lambda_layer ? [aws_lambda_layer_version.lambda_layer[0].arn] : var.layer_arns
  publish           = var.publish
  description       = var.lambda_description

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  #source_code_hash = filebase64sha256("payload/${var.payload_filename}")
  
  runtime                        = var.runtime
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrent_executions

  dynamic "environment" {
    for_each = local.environment_map
    content {
      variables = environment.value
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config
    content{
      subnet_ids         = [vpc_config.value.subnet_ids]
      security_group_ids = [vpc_config.value.security_group_ids]
    }
  }

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_config
    content{
    target_arn = dead_letter_config.value.target_arn
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.log_for_lambda,
  ]

  tags = {
    Environment             = upper(var.tags_environment)
    Project                 = lower(var.tags_project)
    Department              = lower(var.tags_department)
    "Department Data Owner" = lower(var.tags_department_data_owner)
  }
}