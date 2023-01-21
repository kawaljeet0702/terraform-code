module "s3" {
  source                            = ".//s3"
  region                            = var.region
  create_s3                         = var.create_s3
  bucketnames                       = var.bucketname
  versioning_enabled                = var.versioning_enabled
  sse_algorithm                     = var.sse_algorithm
  key_arn                           = var.key_arn
  block_public_policy               = var.block_public_policy
  block_public_acls                 = var.block_public_acls
  ignore_public_acls                = var.ignore_public_acls
  restrict_public_buckets           = var.restrict_public_buckets
  enable_30_30                      = var.enable_30_30
  enable_30                         = var.enable_30
  replication_configuration         = var.replication_configuration
  attach_policy                     = var.attach_policy
  environment                       = var.environment
  policy_filename                   = var.policy_filename
  force_destroy                     = var.force_destroy
  tags_environment                  = var.tags_environment
  tags_project                      = var.tags_project
  tags_department                   = var.tags_department
  tags_department_data_owner        = var.tags_department_data_owner
}

resource "aws_athena_database" "db" {
  count  = var.create_db ? 1 : 0
  name   = var.database_name
  bucket = var.create_s3 ? module.s3.s3_id : var.bucket_arn

  encryption_configuration{
    encryption_option="SSE_KMS"
    kms_key=var.key_arn
  }
}

resource "aws_athena_workgroup" "workgroup" {
  count = var.create_workgroup ? 1 : 0
  name  = var.workgroup_name
  description = var.workgroup_description

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = var.create_s3 ? ("s3://${module.s3.s3_id}/output/") : ("s3://${var.bucket_arn}/output/")

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = var.key_arn
      }
    }
  }
}

resource "aws_athena_named_query" "query" {
  count     = var.create_query ? 1 : 0
  name      = var.query_name
  workgroup = var.create_workgroup ? aws_athena_workgroup.workgroup[0].id : var.exisiting_workgroup_name
  database  = var.create_db ? aws_athena_database.db[0].name : var.existing_db_name
  query     = var.query
}