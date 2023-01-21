#general
region = "us-east-1"
startindex = 0

#kinesis_stream
create_stream       = true
shard_count         = 1
retention_period    = "24"
encryption_type     = "NONE"
arn                 = "arn:aws:iam::xxx:role/xxx"

#tags
tags_name="name"
tags_environment="dev"
tags_project="project"
tags_department="dept"
tags_department_data_owner="owner"