provider "aws" {
  region = var.aws_region
}

data "aws_ecr_repository" "task_repository" {
  name = "task_name"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/ecs/${var.namespace}/task_name-task"
}

data "template_file" "task_definition" {
  template = file("${path.module}/task_definition.json.tpl")

  vars = {
    name                 = var.namespace
    image                = "${data.aws_ecr_repository.task_repository.repository_url}:${var.env}"
    log_group            = aws_cloudwatch_log_group.main.name
    region               = var.aws_region
    logs_volume_source   = "task_name-logs"
      /*provided*/
    mongo_uri            = lookup(var.mongo_uri, var.env)
  }
}


module "scheduled-task" {
  source = "../scheduled-task"

  aws_region                          = var.aws_region
  base_namespace                      = var.namespace
  base_tags                           = var.tags
  env                                 = var.env
  task_name                           = "task_name"
  cluster_name                        = "${var.namespace}-task_name"
  task_definition                     = data.template_file.task_definition.rendered
  ecs_task_execution_role_arn         = var.ecs_task_execution_role_arn
  private_subnet_ids                  = var.private_subnet_ids
  logs_volume_source                  = "task_name-logs"
  memory                              = 2048
  cpu                                 = 256


  event_rule_schedule_expression      = "rate(15 minutes)"
}