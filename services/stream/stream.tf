resource "aws_kinesis_stream" "kinesis_stream" {
  count               = var.create_stream ? 1 : 0
  name                = "${var.tags_name}${var.startindex}"
  shard_count         = var.shard_count
  encryption_type     = var.encryption_type
  kms_key_id          = var.kms_key_alias_arn
  arn                 = var.arn
  retention_period    = var.retention_period
  shard_level_metrics = var.shard_level_metrics

  tags = {
    Name                    = lower("${var.tags_name}${var.startindex}")
    Environment             = upper(var.tags_environment)
    Project                 = lower(var.tags_project)
    Department              = lower(var.tags_department)
   "Department Data Owner"  = lower(var.tags_department_data_owner)
  }
}