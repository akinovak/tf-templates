provider "aws" {
  region = var.aws_region
}

resource "aws_lambda_function" "lambda-function-example" {
  filename      = "${path.module}/lambda_function_payload.zip"
  function_name = "lambda-function-example-name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.lambdaHandler"
  source_code_hash = filebase64sha256("${path.module}/lambda_function_payload.zip")

  runtime = "nodejs14.x"
  timeout = 30

  environment {
    variables = {
       NODE_ENV = var.env,
       REGION = var.aws_region,
    }
  }
}
