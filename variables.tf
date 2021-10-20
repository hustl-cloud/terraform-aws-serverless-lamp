# Required Inputs
variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "app_env" {
  description = "Name of the environment (dev, test, prod)"
  type        = string
}

variable "app_dir" {
  description = "Application directory to package lambda from"
  type = string
}

variable "fqdns" {
  description = "Fully-qualified domain name to use for site"
  type        = list(any)
}

variable "acm_certificate_arn" {
  description = "ACM certificate arn to use"
  type = string
}

# Default Values

variable "app_artifact" {
  description = "Application artifact file name packaged by Serverless Framework"
  type        = string
  default     = "serverless-lamp.zip"
}

## vpc specific, not applied if omitted
variable "subnets" {
  description = "List of subnets to apply to the VPC Lambdas"
  type = list(any)
  default = []
}

variable "security_groups" {
  description = "List of security groups to apply to the VPC Lambdas"
  type = list(any)
  default = []
}

variable "bref_aws_account_id" {
  description = "Bref AWS account id from https://runtimes.bref.sh"
  type = string
  default = "209497400698"
}

variable "bref_fpm_version" {
  description = "Bref PHP-FPM version from runtimes from https://runtimes.bref.sh"
  type = string
  default = "php-80-fpm:21"
}

variable "bref_php_version" {
  description = "Bref PHP version from runtimes from https://runtimes.bref.sh"
  type = string
  default = "php-80:21"  
}

variable "bref_console_version" {
  description = "Bref console version from runtimes from https://runtimes.bref.sh"
  type = string
  default = "console:46"  
}
