output "sqs_url" {
  value       = aws_sqs_queue.sqs.url
  description = "SQS URL"
}

output "sqs_queue_name" {
   value      = aws_sqs_queue.sqs.name
   description = "queue name" 
}

output "sqs_arn" {
  value       = aws_sqs_queue.sqs.arn
  description = "SQS arn"
}
