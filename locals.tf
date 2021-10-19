locals {
  prefix       = "${var.app_name}-${var.app_env}"
  s3_origin_id = "s3-${local.prefix}"
}