# Required

variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "app_env" {
  description = "Name of the environment (dev, test, prod)"
  type        = string
}

variable "fqdns" {
  description = "Fully-qualified domain name to use for site"
  type        = list(any)
}

# Defaults

variable "laravel_root" {
  description = "Laravel project root directory"
  type        = string
}

variable "laravel_zip" {
  description = "Laravel zip file name packaged by Serverless Framework"
  type        = string
  default     = ".serverless/laravel.zip"
}
