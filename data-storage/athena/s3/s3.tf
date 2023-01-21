resource "aws_s3_bucket" "bucket" {
  count  = var.create_s3 ? (length(keys(var.bucketnames))) : 0
  bucket = lower(var.bucketnames[count.index])
  acl    = element(var.bucket_acls, count.index)
  #policy = var.attach_policy ? (file("../../../hdp-variables/${var.environment}/global/s3/policies/${var.policy_filename}")) : ""
  policy = var.attach_policy ? (file("policies/${var.policy_filename}")) : ""
  force_destroy = var.force_destroy

  # Versioning is a means of keeping multiple variants of an object in the same bucket.
  # Versioning-enabled buckets enable you to recover objects from accidental deletion or overwrite.
  #
  # Once you version-enable a bucket, it can never return to an unversioned state.
  # You can, however, suspend versioning on that bucket.
  # https://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html

  versioning {
    enabled = var.versioning_enabled
  }

  #lifecycle rules
  lifecycle_rule {
    id      = "30 Standard IA-30 Expire"
    enabled = var.enable_30_30

    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }
 
    expiration {
      days = 60
    }
  }

  lifecycle_rule {
    id      = "30 Standard IA"
    enabled = var.enable_30

    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }
  }

  dynamic "replication_configuration" {
    for_each = var.replication_configuration
      content{
        role = replication_configuration.value.replication_role_arn

        rules {
          id     = replication_configuration.value.replication_id
          status = "Enabled"

          destination {
            bucket        = replication_configuration.value.replication_bucket_arn
            storage_class = replication_configuration.value.destination_storage_class
          }
        }
      }
  }


  # S3 encrypts your data at the object level as it writes it to disks in its data centers
  # and decrypts it for you when you access it.
  # https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        # The objects are encrypted using server-side encryption with either
        # Amazon S3-managed keys (SSE-S3) or AWS KMS-managed keys (SSE-KMS).
        # https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.key_arn
      }
    }
  }

  tags = {
    Name                    = lower(format(element(keys(var.bucketnames), count.index)))
    Environment             = upper(var.tags_environment)
    Project                 = lower(var.tags_project)
    Department              = lower(var.tags_department)
    "Department Data Owner" = lower(var.tags_department_data_owner)
  }
}

resource "aws_s3_bucket_public_access_block" "accessblock" {
    depends_on              = [aws_s3_bucket.bucket]
    count                   = var.create_s3 ? (length(keys(var.bucketnames))) : 0
    bucket                  = lower(var.bucketnames[count.index])
    block_public_acls       = var.block_public_acls
    block_public_policy     = var.block_public_policy
    ignore_public_acls      = var.ignore_public_acls
    restrict_public_buckets = var.restrict_public_buckets
}