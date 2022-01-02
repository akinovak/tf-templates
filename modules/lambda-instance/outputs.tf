output "lambda_invokation_arn" {
  value       = aws_lambda_function.lambda-function-example.invoke_arn
  description = "lambda invokation URL"
}
output "lambda_function_name" {
  value       = aws_lambda_function.lambda-function-example.function_name
  description = "lambda function name"
}