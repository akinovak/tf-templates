output "base_url" {
  value = aws_api_gateway_deployment.argo_gateway_deployment.invoke_url
}