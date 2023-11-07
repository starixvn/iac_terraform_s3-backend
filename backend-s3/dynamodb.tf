resource "aws_dynamodb_table" "vpc_dynamodb_table" {
  name = "${var.project}-vpc-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lumi_dynamodb_table" {
  name = "${var.project}-lumi-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "starix_dynamodb_table" {
  name = "${var.project}-starix-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_dynamodb_table" "bastion_dynamodb_table" {
  name = "${var.project}-bastion-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lumi_eks_dynamodb_table" {
  name = "${var.project}-lumi-eks-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "route53_dynamodb_table" {
  name = "${var.project}-route53-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lumi_external_lb_dynamodb_table" {
  name = "${var.project}-lumi-external-lb-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "lumi_internal_lb_dynamodb_table" {
  name = "${var.project}-lumi-internal-lb-tf-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}