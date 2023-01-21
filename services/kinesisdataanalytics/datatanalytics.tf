module "kinesis_stream" {
  source                            = "../stream"
  region                            = var.region
  create_stream                     = var.create_stream
  startindex                        = var.startindex
  shard_count                       = var.shard_count
  retention_period                  = var.retention_period
  encryption_type                   = var.encryption_type
  arn                               = var.arn
  tags_name                         = lower("${var.tags_name}${var.startindex}-stream")
  tags_environment                  = var.tags_environment
  tags_project                      = var.tags_project
  tags_department                   = var.tags_department
  tags_department_data_owner        = var.tags_department_data_owner
}

resource "aws_kinesis_analytics_application" "data_analytics" {
  name = "${var.tags_name}${var.startindex}-da"
  count               = var.enable_data_analytics ? 1 : 0
  inputs {
    name_prefix = var.name_prefix

    kinesis_stream {
      resource_arn = var.create_stream ? module.kinesis_stream.stream_arn : var.stream_arn
      role_arn     = var.role_arn
    }

    parallelism {
      count = 1
    }

    schema {
      record_columns {
        mapping  = var.mapping
        name     = var.name_schema
        sql_type = var.sql_type
      }

      record_encoding = var.record_encoding

      record_format {
        mapping_parameters {
          json {
            record_row_path = "$"
          }
        }
      }
    }
  }
  tags = {
    Name                = lower("${var.tags_name}${var.startindex}-da")
    Environment         = upper(var.tags_environment)
    Project             = lower(var.tags_project)
    Department          = lower(var.tags_department)
   "Department Data Owner" = lower(var.tags_department_data_owner)
  }
}