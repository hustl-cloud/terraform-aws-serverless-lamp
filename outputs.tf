output "s3_bucket" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "invoke_url" {
  value = aws_apigatewayv2_stage.this.invoke_url
}