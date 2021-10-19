resource "aws_cloudwatch_log_group" "web" {
  name = "/aws/lambda/${local.prefix}-web"

  tags = {
    Environment = var.app_env
    Application = var.app_name
  }
}

resource "aws_cloudwatch_log_group" "artisan" {
  name = "/aws/lambda/${local.prefix}-artisan"

  tags = {
    Environment = var.app_env
    Application = var.app_name
  }
}