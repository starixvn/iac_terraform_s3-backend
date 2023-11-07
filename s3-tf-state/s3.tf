resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "${var.project}-lumi-starix-tf-${random_pet.this.id}"
  force_destroy = true
  #tags          = local.common_tags
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    #object_ownership = "ObjectWriter"
    object_ownership = "BucketOwnerPreferred"
  }
}

#control_object_ownership = true

resource "aws_s3_bucket_versioning" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled" # Disabled Enabled
  }
}

# resource "aws_kms_key" "kms_key" {
#   tags = local.tags
# }
###KMS fee 0.03/day
# resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket" {
#   bucket = aws_s3_bucket.s3_bucket.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm     = "aws:kms"
#       kms_master_key_id = aws_kms_key.kms_key.arn
#     }
#   }
# }

resource "random_pet" "this" {
  length = 1
}