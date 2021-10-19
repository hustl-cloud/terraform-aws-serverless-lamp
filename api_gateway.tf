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


# resource "aws_apigatewayv2_deployment" "this" {
#   api_id      = aws_apigatewayv2_api.this.id
#   description = ""

#   triggers = {
#     redeployment = sha1(join(",", list(
#       jsonencode(aws_apigatewayv2_integration.lambda),
#       jsonencode(aws_apigatewayv2_route.all),
#     )))
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }



# resource "aws_apigatewayv2_stage" "lambda" {
#   api_id = aws_apigatewayv2_api.this.id

#   name        = local.prefix
#   auto_deploy = true

#   # access_log_settings {
#   #   destination_arn = aws_cloudwatch_log_group.api_gw.arn

#   #   format = jsonencode({
#   #     requestId               = "$context.requestId"
#   #     sourceIp                = "$context.identity.sourceIp"
#   #     requestTime             = "$context.requestTime"
#   #     protocol                = "$context.protocol"
#   #     httpMethod              = "$context.httpMethod"
#   #     resourcePath            = "$context.resourcePath"
#   #     routeKey                = "$context.routeKey"
#   #     status                  = "$context.status"
#   #     responseLength          = "$context.responseLength"
#   #     integrationErrorMessage = "$context.integrationErrorMessage"
#   #     }
#   #   )
#   # }
# }

# resource "aws_apigatewayv2_integration" "hello_world" {
#   api_id = aws_apigatewayv2_api.this.id

#   integration_uri    = aws_lambda_function.hello_world.invoke_arn
#   integration_type   = "AWS_PROXY"
#   integration_method = "POST"
# }

# resource "aws_apigatewayv2_route" "hello_world" {
#   api_id = aws_apigatewayv2_api.lambda.id

#   route_key = "GET /hello"
#   target    = "integrations/${aws_apigatewayv2_integration.hello_world.id}"
# }

# resource "aws_cloudwatch_log_group" "api_gw" {
#   name = "/aws/api_gw/${aws_apigatewayv2_api.lambda.name}"

#   retention_in_days = 30
# }

# resource "aws_lambda_permission" "api_gw" {
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.hello_world.function_name
#   principal     = "apigateway.amazonaws.com"

#   source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
# }