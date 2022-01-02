data "aws_ecr_repository" "repository_name" {
  name = "image-name"
}

resource "aws_ecr_repository_policy" "task_policy" {
  repository = data.aws_ecr_repository.repository_name.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ECR access to the fargate task repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}

resource "aws_ecs_cluster" "ecs_cluster_name" {
  name = local.namespace

  tags = local.default_tags
}

resource "aws_ecs_service" "task_api" {
  platform_version = "1.4.0"
  name             = "${local.namespace}-api"
  cluster          = aws_ecs_cluster.ecs_cluster_name.arn
  task_definition  = aws_ecs_task_definition.task_api.arn
  desired_count    = var.api_count
  launch_type      = "FARGATE"

  network_configuration {
    security_groups = [
      module.api_security_group.this_security_group_id
    ]
    subnets = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name   = "${local.namespace}-api"
    container_port   = local.api_port
  }

  tags = local.default_tags

  depends_on = [
    module.api_security_group,
    module.alb
  ]
}

resource "aws_ecs_task_definition" "task_api_definition" {
  family                = "${local.namespace}-api"
  container_definitions = data.template_file.api_container_definitions.rendered

  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = module.ecs_task_role.this_iam_role_arn
  network_mode       = "awsvpc"

  requires_compatibilities = ["FARGATE"]
  cpu                      = var.api_cpu
  memory                   = var.api_memory

  volume {
    name = "${local.namespace}-logs"
  }

  tags = local.default_tags
}

data "template_file" "api_container_definitions" {
  template = file("${path.module}/templates/container_definitions.json.tpl")

  vars = {
    name      = "${local.namespace}-api"
    image     = "${data.aws_ecr_repository.repository_name.repository_url}:${var.env}"
    log_group = aws_cloudwatch_log_group.main.name
    cpu       = var.api_cpu
    memory    = var.api_memory
    region    = var.aws_region
    app_port  = local.api_port
    logs_volume_source = "${local.namespace}-logs"

    node_env                      = lookup(var.node_env, var.env)
  }
}
