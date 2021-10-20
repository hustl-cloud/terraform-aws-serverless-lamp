output "s3_bucket" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "api_gateway_invoke_url" {
  value = aws_apigatewayv2_stage.this.invoke_url
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}