output "api_url" {
  value = module.api.url
}

output "api_methods" {
  value = module.api.http_method
}

output "lambda_name" {
  value = module.lambda.name
}

output "lambda_arn" {
  value = module.lambda.arn
}