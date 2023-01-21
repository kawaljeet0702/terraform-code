resource "aws_s3_bucket" "bucket" {
  count  = var.create_s3 ? 1 : 0
  bucket = var.bucketname
  acl    = element(var.bucket_acls, count.index)
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

  # S3 encrypts your data at the object level as it writes it to disks in its data centers
  # and decrypts it for you when you access it.
  # https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        # The objects are encrypted using server-side encryption with either
        # Amazon S3-managed keys (SSE-S3) or AWS KMS-managed keys (SSE-KMS).
        # https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html
        sse_algorithm = var.sse_algorithm
      }
    }
  }

  tags = {
    Name                    = var.bucketname
    Environment             = upper(var.tags_environment)
    Project                 = lower(var.tags_project)
    Department              = lower(var.tags_department)
    "Department Data Owner" = lower(var.tags_department_data_owner)
  }
}

  resource "aws_s3_bucket_public_access_block" "accessblock" {
    depends_on = [aws_s3_bucket.bucket]
    count  = var.create_s3 ? 1 : 0
    bucket = var.bucketname
    block_public_acls   = var.block_public_acls
    block_public_policy = var.block_public_policy
    ignore_public_acls = var.ignore_public_acls
    restrict_public_buckets = var.restrict_public_buckets
  }