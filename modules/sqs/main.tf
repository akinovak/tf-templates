provider "aws" {
  region = var.aws_region
}

resource "aws_sqs_queue" "sqs" {
  name                        = "${var.env}-sqs-name"
  visibility_timeout_seconds  = 3600
  fifo_queue                  = true
  content_based_deduplication = true
  tags                        = local.default_tags
}
