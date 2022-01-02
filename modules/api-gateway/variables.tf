variable "lambda_invoke_arn" {
  type        = string
  description = "Deployment scale up lambda invoke arn"
}
variable "lambda_function_name" {
  type        = string
  description = "Deployment scale up lambda function name"
}
variable "env" {
  type        = string
  description = "Environment name"
}