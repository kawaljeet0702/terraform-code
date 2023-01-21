#general
region = "us-east-1"

#kinesis_firehose 
destination                     = "extended_s3"
enable_firehose_stream_input    = true

#kinesis_stream
shard_count        = 1

#stream retention_period in hours
create_stream      = false
retention_period   = "24"
encryption_type    = "NONE"
#stream role arn
arn                = "arn:aws:iam::xxx:role/xxx"
#if create_stream is set to false, then please provide an existing stream arn value below
stream_arn         = "arn:aws:kinesis:us-east-1:xxx:stream/xxx"

#firehose extended_s3_configuration
role_arn           = "arn:aws:iam::xxx:role/xxx"

#Transform source records with AWS Lambda
#If transform has to be disabled, please comment the lines as shown below
processing_configuration =[
      {
      enabled         = true
      type            = "Lambda"
      parameter_name  = "LambdaArn"
      parameter_value = "arn:aws:lambda:us-east-1:xxx:function:xxx:$LATEST"
      }
]

#Convert record format OpenX JSON SerDe to Apache Parquet
convert_record_openxjson_to_parquet =[
      {
        input_case_insensitive0                         = true
        input_convert_dots_in_json_keys_to_underscores0 = false
        output_block_size_bytes0                        = 268435456
        output_compression0                             = "SNAPPY"
        output_enable_dictionary_compression0           = false
        output_max_padding_bytes0                       = 0
        output_page_size_bytes0                         = 1048576
        output_writer_version0                          = "V1"
        glue_region0                                    = "us-east-1"
        glue_database_name0                             = "default"
        glue_role_arn0                                  = "arn:aws:iam::xxx:role/xxx"
        glue_table_name0                                = "name"
        glue_version_id0                                = "LATEST"
      }
]

#Convert record format hive_json_ser_de to Apache Parquet
convert_record_hivejson_to_parquet =[
      /*{
        output_block_size_bytes1                        = 268435456
        output_compression1                             = "SNAPPY"
        output_enable_dictionary_compression1           = false
        output_max_padding_bytes1                       = 0
        output_page_size_bytes1                         = 1048576
        output_writer_version1                          = "V1"
        glue_region1                                    = "us-east-1"
        glue_database_name1                             = "default"
        glue_role_arn1                                  = "arn:aws:iam::xxx:role/xxx"
        glue_table_name1                                = "name"
        glue_version_id1                                = "LATEST"
      }*/
]

#Convert record format hive_json_ser_de to orc_ser_de Apache ORC. 
convert_record_hivejson_to_orc_ser_de =[
      /*{
        output_block_size_bytes2                        = 268435456
        output_bloom_filter_false_positive_probability2 = 0.05
        output_compression2                             = "SNAPPY"
        output_dictionary_key_threshold2                = 0
        output_enable_padding2                          = false
        output_format_version2                          = "V0_12"
        output_padding_tolerance2                       = 0.05
        output_row_index_stride2                        = 10000
        output_stripe_size_bytes2                       = 67108864
        glue_region2                                    = "us-east-1"
        glue_database_name2                             = "default"
        glue_role_arn2                                  = "arn:aws:iam::xxx:role/xxx"
        glue_table_name2                                = "name"
        glue_version_id2                                = "LATEST"
      }*/
]

#Convert record format OpenX JSON SerDe to orc_ser_de Apache ORC. 
convert_record_openxjson_to_orc_ser_de =[
      /*{
        input_case_insensitive3                         = true
        input_convert_dots_in_json_keys_to_underscores3 = false
        output_block_size_bytes3                        = 268435456
        output_bloom_filter_false_positive_probability3 = 0.05
        output_compression3                             = "SNAPPY"
        output_dictionary_key_threshold3                = 0
        output_enable_padding3                          = false
        output_format_version3                          = "V0_12"
        output_padding_tolerance3                       = 0.05
        output_row_index_stride3                        = 10000
        output_stripe_size_bytes3                       = 67108864
        glue_region3                                    = "us-east-1"
        glue_database_name3                             = "default"
        glue_role_arn3                                  = "arn:aws:iam::xxx:role/xxx"
        glue_table_name3                                = "name"
        glue_version_id3                                = "LATEST"
      }*/
]

#Source record S3 backup
#Once set to enabled, you cannot revert back to disabled
source_record_s3_backup_mode = "Enabled"
#If above is set to Enabled, please provide the details below
#If Disabled, then comment the block {}
s3_source_record_backup_configuration =[
      {
            s3_source_record_role_arn   = "arn:aws:iam::xxx:role/xxx"
            s3_source_record_bucket_arn = "arn:aws:s3:::xxx"
            s3_source_record_prefix     = "prefix/"
      }
]

#s3 destination
create_s3                   = false
bucketname                  = "name"
versioning_enabled          = true
sse_algorithm               = "AES256"
block_public_policy         = true
block_public_acls           = true
ignore_public_acls          = true
restrict_public_buckets     = true
force_destroy               = false
#if create_s3 is set to false, then please provide an existing s3 bucket arn value below
bucket_arn                  = "arn:aws:s3:::xxx"
s3_prefix                   = "trans_prod_responsedata/eventdatehour=!{timestamp:yyyy-MM-dd-HH}/"
s3_error_output_prefix      = "error_prod_responsedata/eventdatehour=!{timestamp:yyyy-MM-dd-HH}/!{firehose:error-output-type}"
buffer_size                 = "128"
buffer_interval             = "300"
compression_format          = "UNCOMPRESSED"
s3_encryption               = "arn:aws:kms:us-east-1:xxx:key/xxx"

#tags
tags_name                   ="name"
startindex                  =0
tags_environment            ="dev"
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"