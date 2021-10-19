resource "aws_acm_certificate" "this" {
  domain_name = var.fqdns[0]
  #   subject_alternative_names = var.fqdns

  validation_method = "DNS"

  tags = {
    Environment = var.app_env
  }

  #   lifecycle {
  #     create_before_destroy = true
  #   }
}

# resource "aws_acm_certificate_validation" "this" {
#   certificate_arn = aws_acm_certificate.this.arn
# }