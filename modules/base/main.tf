provider "aws" {
  region = var.aws_region
}

module "sqs" {
  source = "../sqs"

  aws_region     = var.aws_region
  env            = var.env
  base_tags      = local.default_tags
  base_namespace = local.base_namespace
}
module "api-gateway" { 
  source = "../api-gateway"
  lambda_invoke_arn    = module.lambda-instance.lambda_invokation_arn
  lambda_function_name = module.lambda-instance.lambda_function_name
  env                                      = var.env
}