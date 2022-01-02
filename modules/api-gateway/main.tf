provider "aws" {
  region = "us-east-1"
}
resource "aws_api_gateway_rest_api" "gateway_example" {
  name        = "gateway_example"
  description = "Terraform Serverless Application Example"
}

resource "aws_api_gateway_resource" "gwrs_deploy" {
  rest_api_id = "${aws_api_gateway_rest_api.gateway_example.id}"
  parent_id   = "${aws_api_gateway_rest_api.gateway_example.root_resource_id}"
  path_part   = "resource_name"
}

resource "aws_api_gateway_method" "gwmt_deploy" {
  rest_api_id   = "${aws_api_gateway_rest_api.gateway_example.id}"
  resource_id   = "${aws_api_gateway_resource.gwrs_deploy.id}"
  http_method   = "POST"
  authorization = "NONE"
}   


resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.gateway_example.id}"
  resource_id = "${aws_api_gateway_method.gwmt_deploy.resource_id}"
  http_method = "${aws_api_gateway_method.gwmt_deploy.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "gateway_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda,
  ]

  rest_api_id = aws_api_gateway_rest_api.argo_gateway.id
  stage_name  = "stage_name"
}   

  
