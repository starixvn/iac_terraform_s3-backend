resource "aws_dynamodb_table" "vpc_dynamodb_table" {
  name = "${var.project}-vpc-aws-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lumi_dynamodb_table" {
  name = "${var.project}-lumi-aws-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "starix_dynamodb_table" {
  name = "${var.project}-starix-aws-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_dynamodb_table" "bastion_dynamodb_table" {
  name = "${var.project}-bastion-aws-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lumi_eks_dynamodb_table" {
  name = "${var.project}-lumi-eks-aws-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "route53_dynamodb_table" {
  name = "${var.project}-route53-aws-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lumi_external_lb_dynamodb_table" {
  name = "${var.project}-lumi-external-lb-aws-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lumi_internal_lb_dynamodb_table" {
  name = "${var.project}-lumi-internal-lb-aws-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}