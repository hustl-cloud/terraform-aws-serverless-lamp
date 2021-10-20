resource "aws_lambda_function" "web" {
  filename         = "${var.app_dir}/${var.app_artifact}"
  function_name    = "${local.prefix}-web"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "public/index.php"
  source_code_hash = filebase64sha256("${var.app_dir}/${var.app_artifact}")

  runtime     = "provided.al2"
  memory_size = 1024
  timeout     = 28

  environment {
    variables = {
      foo = "bar"
    }
  }

  layers     = ["arn:aws:lambda:${var.aws_region}:${var.bref_aws_account_id}:layer:${var.bref_fpm_version}"]

  vpc_config {
    security_group_ids = var.security_groups
    subnet_ids = var.subnets
  }

  depends_on = [
    null_resource.serverless_package,
    aws_cloudwatch_log_group.web
  ]

}

resource "aws_lambda_function" "artisan" {
  filename         = "${var.app_dir}/${var.app_artifact}"
  function_name    = "${local.prefix}-artisan"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "artisan"
  source_code_hash = filebase64sha256("${var.app_dir}/${var.app_artifact}")

  runtime     = "provided.al2"
  memory_size = 1024
  timeout     = 28

  environment {
    variables = {
      foo = "bar"
    }
  }

  layers = [
    "arn:aws:lambda:${var.aws_region}:${var.bref_aws_account_id}:layer:${var.bref_php_version}",
    "arn:aws:lambda:${var.aws_region}:${var.bref_aws_account_id}:layer:${var.bref_console_version}"
  ]
  
  vpc_config {
    security_group_ids = var.security_groups
    subnet_ids = var.subnets
  }

  depends_on = [
    null_resource.serverless_package,
    aws_cloudwatch_log_group.artisan
  ]

}
