provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      Dept = "VNTeam"
      Team = "Lumi"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


data "aws_region" "current" {}

resource "aws_resourcegroups_group" "resourcegroups_group" {
  name = "${var.project}-s3-backend"
  #tags = local.common_tags
  resource_query {
    query = <<-JSON
      {
        "ResourceTypeFilters": [
          "AWS::AllSupported"
        ],
        "TagFilters": [
          {
            "Key": "project",
            "Values": ["${var.project}"]
          }
        ]
      }
    JSON
  }
}

output "config" {
  value = {
    bucket                  = aws_s3_bucket.s3_bucket.bucket
    region                  = data.aws_region.current.name
    role_arn                = aws_iam_role.iam_role.arn
    vpc_dynamodb_table      = aws_dynamodb_table.vpc_dynamodb_table.name
    route53_dynamodb_table  = aws_dynamodb_table.route53_dynamodb_table.name
    bastion_dynamodb_table  = aws_dynamodb_table.bastion_dynamodb_table.name
    lumi_dynamodb_table     = aws_dynamodb_table.lumi_dynamodb_table.name
    lumi_eks_dynamodb_table = aws_dynamodb_table.lumi_eks_dynamodb_table.name
    lumi_external_lb_dynamodb_table = aws_dynamodb_table.lumi_external_lb_dynamodb_table.name
    lumi_internal_lb_dynamodb_table = aws_dynamodb_table.lumi_internal_lb_dynamodb_table.name
    starix_dynamodb_table   = aws_dynamodb_table.starix_dynamodb_table.name
  }
}