resource "aws_elasticache_cluster" "main" {
  cluster_id           = "messaging-redis-${var.env}"
  engine               = "redis"
  node_type            = "cache.m3.medium"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.6"
  port                 = 6379
  tags                 = local.default_tags
  security_group_ids   = [aws_security_group.default.id]
  subnet_group_name    = "default-subnet"
}

resource "aws_security_group" "default" {
  name   = "${var.env}-elasticache-redis"
  vpc_id = module.vpc.vpc_id
  tags   = local.default_tags
}


resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = var.redis_port
  to_port           = var.redis_port
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}