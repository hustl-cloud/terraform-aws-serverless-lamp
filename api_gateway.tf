resource "aws_apigatewayv2_api" "this" {
  name          = local.prefix
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = var.app_env
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "this" {
  api_id     = aws_apigatewayv2_api.this.id
  route_key  = "$default"
  target     = "integrations/${aws_apigatewayv2_integration.lambda.id}"
  depends_on = [aws_apigatewayv2_integration.lambda]
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.web.invoke_arn
  payload_format_version = "2.0"
  timeout_milliseconds   = 28500
}
