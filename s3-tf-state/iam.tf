data "aws_caller_identity" "current" {}

locals {
  principal_arns = var.principal_arns != null ? var.principal_arns : [data.aws_caller_identity.current.arn]
}

data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.s3_bucket.arn]
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.s3_bucket.arn}/*"]
  }
  #### LOCAL
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:DescribeContinuousBackups", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.vpc_dynamodb_table.arn]
  }
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:DescribeContinuousBackups", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.lumi_dynamodb_table.arn]
  }
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:DescribeContinuousBackups", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.starix_dynamodb_table.arn]
  }
  ##Bastion
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:DescribeContinuousBackups", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.bastion_dynamodb_table.arn]
  }
  ##EKS
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:DescribeContinuousBackups", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.lumi_eks_dynamodb_table.arn]
  }
  ##Route53
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:DescribeContinuousBackups", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.route53_dynamodb_table.arn]
  }
  ##LB
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:DescribeContinuousBackups", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.lumi_external_lb_dynamodb_table.arn]
  }
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:DescribeContinuousBackups", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.lumi_internal_lb_dynamodb_table.arn]
  }


}

resource "aws_iam_policy" "policy" {
  name   = "LumiStarix${title(var.project)}S3BackendPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.policy_doc.json
  tags = local.common_tags
}

resource "aws_iam_role" "iam_role" {
  name = "LumiStarix${title(var.project)}S3BackendRole"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
        "AWS": ${jsonencode(local.principal_arns)}
      },
      "Effect": "Allow"
      }
    ]
  }
  EOF

}

resource "aws_iam_role_policy_attachment" "policy_attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.policy.arn
}
#############################################################
##VAULT
#############################################################
module "iam_assumable_role_vault_trust_policy_v1" {
  source      = "gitlab.nexdev.net/iac/aws-iam/aws//modules/iam-assumable-role"
  version     = "5.17.1"
  create_role = true
  create_instance_profile = true
  role_name = lower("${var.team}-${var.environment}-vault-Role-v1")

  custom_role_trust_policy = data.aws_iam_policy_document.custom_trust_vault_v1.json
  custom_role_policy_arns  = ["${module.iam_policy_vault_v1.arn}"]
  tags                     = local.common_tags
}

data "aws_iam_policy_document" "custom_trust_vault_v1" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::584102114761:user/nexops.ci","arn:aws:iam::584102114761:user/vault-unseal"]
    }
  }
}


module "iam_policy_vault_v1" {
  source  = "gitlab.nexdev.net/iac/aws-iam/aws//modules/iam-policy"
  version = "5.17.1"

  name        = lower("${var.team}-${var.environment}-vault-v1")
  path        = "/"
  description = "Managed by vnTerraform"
  policy = <<EOF
{
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ],
    "Version": "2012-10-17"
}
EOF

  tags = local.common_tags
}

