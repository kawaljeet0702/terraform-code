#variable "name" {
#}

variable "startindex" {
  default = 0
}

variable "region" {
}

variable "encryption_type" {
}

variable "arn" {
}

variable "kms_key_alias_arn" {
  default = ""
}

variable "shard_count" {
  description = "The number of shards that the stream will use."
  //  Amazon has guidelines for specifying the Stream size that should be referenced when creating a Kinesis stream.
  //  See [Amazon Kinesis Streams](https://docs.aws.amazon.com/streams/latest/dev/amazon-kinesis-streams.html) for more.
}

/**
 * optional variables.
 */

variable "retention_period" {
  description = "Length of time data records are accessible after they are added to the stream."
  default     = "24"
  //  The maximum value of a stream's retention period is 168 hours. Minimum value is 24."
}

variable "shard_level_metrics" {
  type        = list(string)
  description = "A list of shard-level CloudWatch metrics which can be enabled for the stream."
  default     = ["IncomingBytes", "OutgoingBytes"]
  //  See [Monitoring with CloudWatch](https://docs.aws.amazon.com/streams/latest/dev/monitoring-with-cloudwatch.html)
  // for more. Note that the value ALL should not be used; instead you should provide an explicit list of metrics you
  // wish to enable."
}

#kinesis_default_variables
variable "create_stream" {
  default = false
}

variable "destination" {
}

variable "stream_arn" {
  type = string
}

variable "role_arn" {
}

variable "bucket_arn" {
}

variable "buffer_size" {
}

variable "buffer_interval" {
}

variable "compression_format" {
}

variable "cloudwatch_logging" {
  default = "true"
}

variable "enable_firehose_stream_input" {
  default = false
}

variable "processing_configuration" {
    type = list(object({
      enabled         = bool
      type            = string
      parameter_name  = string
      parameter_value = string
    }))

    default = [
        {
          enabled         = null
          type            = null
          parameter_name  = null
          parameter_value = null
        }
      ]
}

variable "convert_record_openxjson_to_parquet" {
    type = list(object({
      glue_database_name0                             = string
      glue_region0                                    = string
      glue_role_arn0                                  = string
      glue_table_name0                                = string
      glue_version_id0                                = string
      input_case_insensitive0                         = bool
      input_convert_dots_in_json_keys_to_underscores0 = bool
      output_block_size_bytes0                        = number
      output_compression0                             = string
      output_enable_dictionary_compression0           = bool
      output_max_padding_bytes0                       = number
      output_page_size_bytes0                         = number
      output_writer_version0                          = string
    }))

    default = [
        {
          glue_database_name0                             = null
          glue_region0                                    = null
          glue_role_arn0                                  = null
          glue_table_name0                                = null
          glue_version_id0                                = null
          input_case_insensitive0                         = null
          input_convert_dots_in_json_keys_to_underscores0 = null
          output_block_size_bytes0                        = null
          output_compression0                             = null
          output_enable_dictionary_compression0           = null
          output_max_padding_bytes0                       = null
          output_page_size_bytes0                         = null
          output_writer_version0                          = null
        }
      ]
}

variable "convert_record_hivejson_to_parquet" {
    type = list(object({
      glue_database_name1                             = string
      glue_region1                                    = string
      glue_role_arn1                                  = string
      glue_table_name1                                = string
      glue_version_id1                                = string
      output_block_size_bytes1                        = number
      output_compression1                             = string
      output_enable_dictionary_compression1           = bool
      output_max_padding_bytes1                       = number
      output_page_size_bytes1                         = number
      output_writer_version1                          = string
    }))

    default = [
        {
          glue_database_name1                             = null
          glue_region1                                    = null
          glue_role_arn1                                  = null
          glue_table_name1                                = null
          glue_version_id1                                = null
          output_block_size_bytes1                        = null
          output_compression1                             = null
          output_enable_dictionary_compression1           = null
          output_max_padding_bytes1                       = null
          output_page_size_bytes1                         = null
          output_writer_version1                          = null
        }
      ]
}

variable "convert_record_hivejson_to_orc_ser_de" {
    type = list(object({
      glue_database_name2                             = string
      glue_region2                                    = string
      glue_role_arn2                                  = string
      glue_table_name2                                = string
      glue_version_id2                                = string
      output_block_size_bytes2                        = number
      output_bloom_filter_false_positive_probability2 = number
      output_compression2                             = string
      output_dictionary_key_threshold2                = number
      output_enable_padding2                          = bool
      output_format_version2                          = string
      output_padding_tolerance2                       = number
      output_row_index_stride2                        = number
      output_stripe_size_bytes2                       = number
    }))

    default = [
        {
          glue_database_name2                             = null
          glue_region2                                    = null
          glue_role_arn2                                  = null
          glue_table_name2                                = null
          glue_version_id2                                = null
          output_block_size_bytes2                        = null
          output_bloom_filter_false_positive_probability2 = null
          output_compression2                             = null
          output_dictionary_key_threshold2                = null
          output_enable_padding2                          = null
          output_format_version2                          = null
          output_padding_tolerance2                       = null
          output_row_index_stride2                        = null
          output_stripe_size_bytes2                       = null
        }
      ]
}

variable "convert_record_openxjson_to_orc_ser_de" {
    type = list(object({
      glue_database_name3                             = string
      glue_region3                                    = string
      glue_role_arn3                                  = string
      glue_table_name3                                = string
      glue_version_id3                                = string
      output_block_size_bytes3                        = number
      output_bloom_filter_false_positive_probability3 = number
      output_compression3                             = string
      output_dictionary_key_threshold3                = number
      output_enable_padding3                          = bool
      output_format_version3                          = string
      output_padding_tolerance3                       = number
      output_row_index_stride3                        = number
      output_stripe_size_bytes3                       = number
      input_case_insensitive3                         = bool
      input_convert_dots_in_json_keys_to_underscores3 = bool
    }))

    default = [
        {
          glue_database_name3                             = null
          glue_region3                                    = null
          glue_role_arn3                                  = null
          glue_table_name3                                = null
          glue_version_id3                                = null
          output_block_size_bytes3                        = null
          output_bloom_filter_false_positive_probability3 = null
          output_compression3                             = null
          output_dictionary_key_threshold3                = null
          output_enable_padding3                          = null
          output_format_version3                          = null
          output_padding_tolerance3                       = null
          output_row_index_stride3                        = null
          output_stripe_size_bytes3                       = null
          input_case_insensitive3                         = null
          input_convert_dots_in_json_keys_to_underscores3 = null
        }
      ]
}

#s3

variable "s3_source_record_backup_configuration" {
    type = list(object({
      s3_source_record_role_arn   = string
      s3_source_record_bucket_arn = string
      s3_source_record_prefix     = string
    }))

    default = [
        {
          s3_source_record_role_arn   = null
          s3_source_record_bucket_arn = null
          s3_source_record_prefix     = null
        }
      ]
}

variable "source_record_s3_backup_mode" {
  default = "Disabled"
}


variable "create_s3" {
  default = false
}

variable "s3_prefix" {
  default = null
}

variable "s3_error_output_prefix" {
  default = null
}

variable "s3_encryption" {
  default = ""
}

variable "bucketname" {
  type = string
}

variable "versioning_enabled" {
  type        = string
  default     = true
  description = "Enable versioning. Versioning is a means of keeping multiple variants of an object in the same bucket."
}

variable "sse_algorithm" {
  default = "AES256"
}

variable "block_public_policy" {
  default = true
}

variable "block_public_acls" {
  default = true
}

variable "ignore_public_acls" {
  default = true
}

variable "restrict_public_buckets" {
  default = true
}

variable "force_destroy" {
  default = false
}

#tags 

variable "tags_environment" {
  description = "(Mandatory)Used to distinguish between development, test, and production infrastructure"
  type        = string
}

variable "tags_name" {
  description = "(Mandatory)A cosmetic, compound tag used to help identify, sort, group, and troubleshoot resources in AWS consoles,etc. and <region using>-<short environment name>-<short app name>-<short app tier>)."
  type        = string
}

variable "tags_project" {
  description = "(Optional)Used to identify the project(s) the resource supports."
  type        = string
  default     = "undefined"
}

variable "tags_department" {
  description = "(Mandatory)Used to identify the department associated with the resource"
  type        = string
}

variable "tags_department_data_owner" {
  description = "(Mandatory)Used to identify the department associated with the dataowner"
  type        = string
}
