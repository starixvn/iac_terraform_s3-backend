# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  #default     = "ap-northeast-1"
}

variable "project" {
  description = "The project name to use for unique resource naming"
  #default     = "nex-lu-aws-local"
  type = string
}

variable "principal_arns" {
  description = "A list of principal arns allowed to assume the IAM role"
  default     = null
  type        = list(string)
}
variable "environment" {
  description = "environment"
  type        = string
}

variable "aws_profile" {
  description = "aws profile"
  type        = string
}

variable "team" {
  description = "Team name"
  type        = string
}