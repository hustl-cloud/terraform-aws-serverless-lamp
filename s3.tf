resource "aws_s3_bucket" "this" {
  bucket = "${local.prefix}-assets"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${local.prefix}-assets"
    Environment = var.app_env
  }
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for ${local.prefix}"
}

# bucket policy for OAI

data "aws_iam_policy_document" "this" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}