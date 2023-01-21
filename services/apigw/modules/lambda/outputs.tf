//
// Module: lambda
//

output "arn" {
  value = aws_lambda_function.lambda[0].arn
}

output "arn_invoke" {
  value = aws_lambda_function.lambda[0].invoke_arn
}

output "name" {
  value = aws_lambda_function.lambda[0].function_name
}

output "id" {
  value = aws_lambda_function.lambda[0].id
}