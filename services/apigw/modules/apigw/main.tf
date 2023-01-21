# API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name                     = var.name
  description              = var.description
  binary_media_types       = var.binary_type
  minimum_compression_size = var.minimum_compression_size

  endpoint_configuration {
    types = var.endpoint_type
  }
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.path_part
}

# Requests mapping
resource "aws_api_gateway_method" "request_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = var.lambda_method
  authorization = var.authorization
}

resource "aws_api_gateway_integration" "request_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_method.request_method.resource_id
  http_method = aws_api_gateway_method.request_method.http_method
  type        = "AWS_PROXY"
  uri         = var.lambda_arn_invoke

  # AWS lambdas can only be invoked with the POST method
  integration_http_method = "POST"
}
/*
# OPTIONS are needed for COORS
resource "aws_api_gateway_method" "options_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "options_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"      = true
    "method.response.header.Access-Control-Allow-Headers"     = true
    "method.response.header.Access-Control-Allow-Methods"     = true
    "method.response.header.Access-Control-Allow-Credentials" = true
  }

  depends_on = [aws_api_gateway_method.options_method]
}

resource "aws_api_gateway_integration" "options_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.options_method.http_method

  type             = "MOCK"
  content_handling = "CONVERT_TO_TEXT"

  depends_on = [aws_api_gateway_method.options_method]
}

resource "aws_api_gateway_integration_response" "options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = aws_api_gateway_method_response.options_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,X-Amz-User-Agent'"
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,DELETE,GET,HEAD,PATCH,POST,PUT'"
  }

  depends_on = [
    aws_api_gateway_method_response.options_200,
    aws_api_gateway_integration.options_integration,
  ]
}
*/

# Deployment
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage

  depends_on = [
    #aws_api_gateway_integration.options_integration,
    aws_api_gateway_integration.request_integration,
  ]
}

# API Permissions
resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = var.lambda_arn
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"

  depends_on = [
    aws_api_gateway_rest_api.api,
    aws_api_gateway_resource.proxy,
  ]
}


# Rest API Reource Policy
resource "aws_api_gateway_rest_api_policy" "policy" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  policy = file("../../../variables/${var.stage}/services/apigw/policies/${var.rest_api_policy_filename}")
  #policy = file("policies/${var.rest_api_policy_filename}")
  /*policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "execute-api:Invoke",
      "Resource": "${aws_api_gateway_rest_api.api.execution_arn}",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "123.123.123.123/32"
        }
      }
    }
  ]
}
EOF*/
}

# API Key
resource "aws_api_gateway_api_key" "ApiKey" {
  name = "demokey"
  enabled= true
}

# API Gateway Method Settings
resource "aws_api_gateway_method_settings" "settings" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage
  method_path = "${trimprefix(aws_api_gateway_resource.proxy.path, "/")}/${aws_api_gateway_method.request_method.http_method}"

  settings {
    metrics_enabled = var.metrics_enabled
    logging_level   = var.logging_level
    throttling_burst_limit = var.throttling_burst_limit
    throttling_rate_limit = var.throttling_rate_limit
    caching_enabled = var.caching_enabled
    cache_data_encrypted = var.cache_data_encrypted
    cache_ttl_in_seconds = var.cache_ttl_in_seconds
  }

  depends_on = [aws_api_gateway_deployment.deployment]
}
