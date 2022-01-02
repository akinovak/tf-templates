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

module "fargate" {
  source = "../fargate"

  env                         = var.env
  aws_region                  = var.aws_region
  az_count                    = lookup(var.az_count, var.env)
  api_count                   = lookup(var.api_count, var.env)
  api_cpu                     = lookup(var.api_cpu, var.env)
  api_memory                  = lookup(var.api_memory, var.env)
  base_namespace              = "some namespace"
  base_tags                   = "tags"
  ecs_task_execution_role_arn = module.ecs_task_execution_role.this_iam_role_arn
  ecs_task_execution_role_id  = module.ecs_task_execution_role.this_iam_role_name
  private_subnet_ids          = module.vpc.private_subnets
  public_subnet_ids           = module.vpc.public_subnets
  vpc_cidr_block              = module.vpc.vpc_cidr_block
  vpc_id                      = module.vpc.vpc_id
  vpc_security_group_id       = module.vpc.default_security_group_id
}