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

module "kinesis_s3" {
  source                            = ".//s3"
  region                            = var.region
  create_s3                         = var.create_s3
  bucketname                        = var.bucketname
  versioning_enabled                = var.versioning_enabled
  sse_algorithm                     = var.sse_algorithm
  block_public_policy               = var.block_public_policy
  block_public_acls                 = true
  ignore_public_acls                = true
  restrict_public_buckets           = true
  force_destroy                     = var.force_destroy
  tags_environment                  = var.tags_environment
  tags_project                      = var.tags_project
  tags_department                   = var.tags_department
  tags_department_data_owner        = var.tags_department_data_owner
}

resource "aws_kinesis_firehose_delivery_stream" "firehose" {
  count       = var.enable_firehose_stream_input ? 1 : 0
  name        = "${var.tags_name}${var.startindex}"
  destination = var.destination

  kinesis_source_configuration {
   kinesis_stream_arn     = var.create_stream ? module.kinesis_stream.stream_arn : var.stream_arn
   role_arn               = var.role_arn
  }

  extended_s3_configuration {
    role_arn             = var.role_arn
    bucket_arn           = var.create_s3 ? module.kinesis_s3.s3_arn : var.bucket_arn
    prefix               = var.s3_prefix
    error_output_prefix  = var.s3_error_output_prefix
    buffer_size          = var.buffer_size
    buffer_interval      = var.buffer_interval
    compression_format   = var.compression_format
    kms_key_arn          = var.s3_encryption
    s3_backup_mode       = var.source_record_s3_backup_mode

    dynamic "s3_backup_configuration" {
      for_each = var.s3_source_record_backup_configuration
      content{
        role_arn   = s3_backup_configuration.value.s3_source_record_role_arn
        bucket_arn = s3_backup_configuration.value.s3_source_record_bucket_arn
        prefix     = s3_backup_configuration.value.s3_source_record_prefix
      }
    }

    cloudwatch_logging_options {
      enabled         = var.cloudwatch_logging
      log_group_name  = "/aws/kinesisfirehose/${var.tags_name}${var.startindex}"
      log_stream_name = "${var.tags_name}${var.startindex}"
    }

    dynamic "processing_configuration" {
      for_each = var.processing_configuration
      content{
        enabled         = processing_configuration.value.enabled
        processors {
        type            = processing_configuration.value.type
          parameters {
            parameter_name  = processing_configuration.value.parameter_name
            parameter_value = processing_configuration.value.parameter_value
          }
        }
      }
    }


    dynamic "data_format_conversion_configuration" {
      for_each = var.convert_record_openxjson_to_parquet
      content{
        input_format_configuration {
          deserializer {
            open_x_json_ser_de {
              case_insensitive                         = data_format_conversion_configuration.value.input_case_insensitive0
              convert_dots_in_json_keys_to_underscores = data_format_conversion_configuration.value.input_convert_dots_in_json_keys_to_underscores0
            }
          }
        }
      

        output_format_configuration {
          serializer {
            parquet_ser_de {
              block_size_bytes              = data_format_conversion_configuration.value.output_block_size_bytes0
              compression                   = data_format_conversion_configuration.value.output_compression0
              enable_dictionary_compression = data_format_conversion_configuration.value.output_enable_dictionary_compression0
              max_padding_bytes             = data_format_conversion_configuration.value.output_max_padding_bytes0
              page_size_bytes               = data_format_conversion_configuration.value.output_page_size_bytes0
              writer_version                = data_format_conversion_configuration.value.output_writer_version0
            }
          }
        }

        schema_configuration {
          region        = data_format_conversion_configuration.value.glue_region0
          database_name = data_format_conversion_configuration.value.glue_database_name0
          role_arn      = data_format_conversion_configuration.value.glue_role_arn0
          table_name    = data_format_conversion_configuration.value.glue_table_name0
          version_id    = data_format_conversion_configuration.value.glue_version_id0
        }
      }
    }


    dynamic "data_format_conversion_configuration" {
      for_each = var.convert_record_hivejson_to_parquet
      content{
        input_format_configuration {
          deserializer {
            hive_json_ser_de {}
          }
        }
      

        output_format_configuration {
          serializer {
            parquet_ser_de {
              block_size_bytes              = data_format_conversion_configuration.value.output_block_size_bytes1
              compression                   = data_format_conversion_configuration.value.output_compression1
              enable_dictionary_compression = data_format_conversion_configuration.value.output_enable_dictionary_compression1
              max_padding_bytes             = data_format_conversion_configuration.value.output_max_padding_bytes1
              page_size_bytes               = data_format_conversion_configuration.value.output_page_size_bytes1
              writer_version                = data_format_conversion_configuration.value.output_writer_version1
            }
          }
        }

        schema_configuration {
          region        = data_format_conversion_configuration.value.glue_region1
          database_name = data_format_conversion_configuration.value.glue_database_name1
          role_arn      = data_format_conversion_configuration.value.glue_role_arn1
          table_name    = data_format_conversion_configuration.value.glue_table_name1
          version_id    = data_format_conversion_configuration.value.glue_version_id1
        }
      }
    }

    dynamic "data_format_conversion_configuration" {
      for_each = var.convert_record_hivejson_to_orc_ser_de
      content{
        input_format_configuration {
          deserializer {
            hive_json_ser_de {}
          }
        }
      

        output_format_configuration {
          serializer {
            orc_ser_de {
              block_size_bytes                        = data_format_conversion_configuration.value.output_block_size_bytes2
              bloom_filter_false_positive_probability = data_format_conversion_configuration.value.output_bloom_filter_false_positive_probability2
              compression                             = data_format_conversion_configuration.value.output_compression2
              dictionary_key_threshold                = data_format_conversion_configuration.value.output_dictionary_key_threshold2
              enable_padding                          = data_format_conversion_configuration.value.output_enable_padding2
              format_version                          = data_format_conversion_configuration.value.output_format_version2
              padding_tolerance                       = data_format_conversion_configuration.value.output_padding_tolerance2
              row_index_stride                        = data_format_conversion_configuration.value.output_row_index_stride2
              stripe_size_bytes                       = data_format_conversion_configuration.value.output_stripe_size_bytes2
            }
          }
        }

        schema_configuration {
          region        = data_format_conversion_configuration.value.glue_region2
          database_name = data_format_conversion_configuration.value.glue_database_name2
          role_arn      = data_format_conversion_configuration.value.glue_role_arn2
          table_name    = data_format_conversion_configuration.value.glue_table_name2
          version_id    = data_format_conversion_configuration.value.glue_version_id2
        }
      }
    }

    dynamic "data_format_conversion_configuration" {
      for_each = var.convert_record_openxjson_to_orc_ser_de
      content{
        input_format_configuration {
          deserializer {
            open_x_json_ser_de {
              case_insensitive                         = data_format_conversion_configuration.value.input_case_insensitive3
              convert_dots_in_json_keys_to_underscores = data_format_conversion_configuration.value.input_convert_dots_in_json_keys_to_underscores3
            }
          }
        }
      

        output_format_configuration {
          serializer {
            orc_ser_de {
              block_size_bytes                        = data_format_conversion_configuration.value.output_block_size_bytes3
              bloom_filter_false_positive_probability = data_format_conversion_configuration.value.output_bloom_filter_false_positive_probability3
              compression                             = data_format_conversion_configuration.value.output_compression3
              dictionary_key_threshold                = data_format_conversion_configuration.value.output_dictionary_key_threshold3
              enable_padding                          = data_format_conversion_configuration.value.output_enable_padding3
              format_version                          = data_format_conversion_configuration.value.output_format_version3
              padding_tolerance                       = data_format_conversion_configuration.value.output_padding_tolerance3
              row_index_stride                        = data_format_conversion_configuration.value.output_row_index_stride3
              stripe_size_bytes                       = data_format_conversion_configuration.value.output_stripe_size_bytes3
            }
          }
        }

        schema_configuration {
          region        = data_format_conversion_configuration.value.glue_region3
          database_name = data_format_conversion_configuration.value.glue_database_name3
          role_arn      = data_format_conversion_configuration.value.glue_role_arn3
          table_name    = data_format_conversion_configuration.value.glue_table_name3
          version_id    = data_format_conversion_configuration.value.glue_version_id3
        }
      }
    }

    /*
    data_format_conversion_configuration {
      input_format_configuration {
        deserializer {
          open_x_json_ser_de {}
        }
      }
    

      output_format_configuration {
        serializer {
          parquet_ser_de {}
        }
      }

      schema_configuration {
        database_name = "default"
        role_arn      = "arn:aws:iam::xxx:role/xxx"
        table_name    = "name"
        version_id    = "LATEST"
      }
    }
    */
  }

  tags = {
    Name                = lower("${var.tags_name}${var.startindex}")
    Environment         = upper(var.tags_environment)
    Project             = lower(var.tags_project)
    Department          = lower(var.tags_department)
    "Department Data Owner" = lower(var.tags_department_data_owner)
  }
}

resource "aws_kinesis_firehose_delivery_stream" "firehose_direct_put" {
  count       = var.enable_firehose_stream_input ? 0 : 1
  name        = "${var.tags_name}${var.startindex}"
  destination = var.destination

  extended_s3_configuration {
    role_arn            = var.role_arn
    bucket_arn            = var.create_s3 ? module.kinesis_s3.s3_arn : var.bucket_arn
    //prefix              = var.s3_prefix
    //error_output_prefix = var.s3_error_output_prefix
    buffer_size         = var.buffer_size
    buffer_interval     = var.buffer_interval
    compression_format  = var.compression_format

    cloudwatch_logging_options {
      enabled         = var.cloudwatch_logging
      log_group_name  = "/aws/kinesisfirehose/${var.tags_name}${var.startindex}"
      log_stream_name = "${var.tags_name}${var.startindex}"
    }

    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "arn:aws:lambda:us-east-1:xxx:function:xxx:$LATEST"
        }
      }
    }

  }

  tags = {
    Name                = lower("${var.tags_name}${var.startindex}")
    Environment         = upper(var.tags_environment)
    Project             = lower(var.tags_project)
    Department          = lower(var.tags_department)
    "Department Data Owner" = lower(var.tags_department_data_owner)
  }
}