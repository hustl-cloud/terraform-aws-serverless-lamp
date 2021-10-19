resource "aws_lambda_function" "web" {
  filename         = "${var.laravel_root}/${var.laravel_zip}"
  function_name    = "${local.prefix}-web"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "public/index.php"
  source_code_hash = filebase64sha256("${var.laravel_root}/${var.laravel_zip}")

  runtime     = "provided.al2"
  memory_size = 1024
  timeout     = 28

  environment {
    variables = {
      foo = "bar"
    }
  }

  layers     = ["arn:aws:lambda:us-east-1:209497400698:layer:php-80-fpm:21"]
  depends_on = [aws_cloudwatch_log_group.web]

}

resource "aws_lambda_function" "artisan" {
  filename         = "${var.laravel_root}/${var.laravel_zip}"
  function_name    = "${local.prefix}-artisan"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "artisan"
  source_code_hash = filebase64sha256("${var.laravel_root}/${var.laravel_zip}")

  runtime     = "provided.al2"
  memory_size = 1024
  timeout     = 28

  environment {
    variables = {
      foo = "bar"
    }
  }

  layers = [
    "arn:aws:lambda:us-east-1:209497400698:layer:php-80:21",
    "arn:aws:lambda:us-east-1:209497400698:layer:console:46"
  ]

  depends_on = [aws_cloudwatch_log_group.artisan]

}








# resource "aws_lambda_permission" "api_gw" {
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.default.function_name
#   principal     = "apigateway.amazonaws.com"

#   source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
# }