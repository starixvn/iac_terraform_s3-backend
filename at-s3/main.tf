module "s3_bucket" {
  source                   = "gitlab.nexdev.net/iac/aws-s3/aws"
  version                  = "5.8.1" #"3.15.2"
  bucket                   = lower("${var.dept}-tf-state-s3")
  region                   = var.aws_region
  attach_policy            = true
  policy                   = data.aws_iam_policy_document.bucket_policy.json
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  # S3 bucket-level Public Access Block configuration (by default now AWS has made this default as true for S3 bucket-level block public access)
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    enabled = true
  }

  tags = merge(
    local.common_tags,
    {
      Resource = "S3"
    },
  )
}

resource "aws_iam_role" "this" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
#################################

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "ListObjectsInBucket"
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.dept}-tf-state-s3",
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.ingress_cidr_blocks
    }

  }

  statement {
    sid = "AllObjectActions"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:*Object*"
    ]

    resources = [
      "arn:aws:s3:::${var.dept}-tf-state-s3/*",
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.ingress_cidr_blocks
    }
  }
}
