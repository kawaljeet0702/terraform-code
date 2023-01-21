#general
region = "us-east-1"

#kinesis_data_analytics
name_prefix             = "test_prefix"
mapping                 = "$.test"
name                    = "test"
sql_type                = "VARCHAR(8)"
record_encoding         = "UTF-8"
record_format_type      = "JSON"
role_arn                = "arn:aws:iam::xxx:role/xxx"
name_schema             = "htest"
enable_data_analytics   = true

#kinesis_stream
shard_count        = 1
retention_period   = "24"
encryption_type    = "NONE"
arn                = "arn:aws:iam::xxx:role/xxx"
create_stream      = false
#if create_stream is set to false, then please provide an existing stream arn value below
stream_arn         = "arn:aws:kinesis:us-east-1:xxx:stream/xxx"

#tags
tags_name                   ="name"
tags_environment            ="dev"
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"