#region
region="us-east-1"
#Glue
name="name"
description="desc"
ser_de_info="mystream"
tablename = "tablename"
databasename="dbname"
external_type = "true"
parquet_compression = "columnar"
crawler_schema_serializer_version = "1.0"
crawler_schema_deserializer_version = "1.0"
table_type = "EXTERNAL_TABLE"
compressed = "true"
retention = 0
compression_type = "columnar"
classification = "json"
typeofdata = "kinesis"
streamname = "terraform-test"
kinesisurl = "https://kinesis.us-east-1.amazonaws.com"
serialization_library = "org.openx.data.jsonserde.JsonSerDe"
serialization_format = 1
#input_format = "json,csv,xml,avro" #for reference
input_format = "json"
output_format = "parquet"
env_name="dev"
s3_bucket = "s3://xxx-datalake"
redshift_location = "dev.rpt.test_api" 
enable_database=true

#use case 1:  take data from postgreSQL , transform and load to datalake ( s3 ) in a parquet format.
s3_catalog_table=true
enable_postgres_crawler=true
enable_postgres_connection=true
enable_s3=true

#use case 2 : take data from kinesis  and summaries and load to redshift.
redshift_catalog_table=true
enable_redshift_crawler=true
enable_redshift_connection=true
enable_redshift=true

#Postgres Database#
#postgres_username="usr"
#postgres_password="passwd"
postgres_username ="USER"
postgres_password ="PASSWD"
postgres_name="postgres"
postgres_connection="jdbc:postgresql://inf-postgres.cdsfdsf3234.us-east-1.rds.amazonaws.com:5432/postgres"
az_postgres="us-east-1a"
securitygroupid_postgres=["sg-fdsf32423"]
subnetid_postgres="subnet-34234fdsf"
role_arn="arn:aws:iam::xxx:role/xxx"

#Redshift Database#
#redshift_username="usr"
#redshift_password="passwd"
#redshift_username="testapi"
#redshift_password="Test-passwd"
redshift_username ="USER"
redshift_password ="PASSWD"
redshift_name="dev"
redshift_connection="jdbc:redshift://tspoc-dev.34234df.us-east-1.redshift.amazonaws.com:5439/dev"
az_redshift="us-east-1b"
securitygroupid_redshift= ["sg-23423fdsfds", "sg-dsdf32423"]
subnetid_redshift="subnet-dsfdsf34234"

#Postgres Crawler#
postgres_database="aws_glue_catalog_database.dev-glue-db"
postgres_cron="cron(0 1 * * ? *)"
postgres_crawler="postgres-crawler"
postgres_connection_name="postgres"
postgres_path="postgres/%"

#Redshift Crawler#
redshift_database="aws_glue_catalog_database.dev-glue-db"
redshift_cron="cron(0 1 * * ? *)"
redshift_crawler="redshift-crawler"
redshift_connection_name="dev"
redshift_path="dev/%"

#Postgres Job#
postgres_connection_job=["postgres"]
postgres_script_location="s3://xxx/dim_market_transform.py"
pythonjob="sample-1"

#redshift Job#
redshift_connection_job=["dev"]
redshift_script_location="s3://curated-datalake/redshift-transformation/test_glue.py"
redshiftjob="sample-2"


#Table-Columns#
columns = [
     {
     column_name = "upd_batch_id"
     column_type = "integer"
   },

    {
     column_name = "sort_order"
     column_type = "smallint"
   },

    {
     column_name    = "days"
     column_type    = "smallint"
   },

    {
     column_name    = "pace_id"
     column_type    = "smallint"
   },

    {
     column_name    = "ins_batch_id"
     column_type    = "integer"
   },
   
    {
     column_name    = "pace_category"
     column_type    = "character varying"
   },

    {
     column_name    = "pace_month"
     column_type    = "character varying"
   },

    {
     column_name    = "reservation_dt"
     column_type    = "timestamp without time zone"
   },

    {
     column_name    = "pii_resv_conf_tkn_key"
     column_type    = "integer"
   },

    {
     column_name    = "conf_page"
     column_type    = "smallint"
   },

    {
     column_name    = "pii_column_name_tkn_key"
     column_type    = "integer"
   },

    {
     column_name    = "pii_guest_tkn_key"
     column_type    = "bigint"
   },

    {
     column_name    = "pii_addr_tkn_key"
     column_type    = "integer"
   },

    {
     column_name    = "pii_phn_tkn_key"
     column_type    = "integer"
   },

    {
     column_name    = "pii_fax_tkn_key "
     column_type    = "integer"
   },

    {
     column_name    = "pii_lp_mem_tkn_key"
     column_type    = "integer"
   },

    {
     column_name    = "property_id"
     column_type    = "integer"
   },

    {
     column_name    = "resv_status_id"
     column_type    = "integer"
   },

    {
     column_name    = "resv_agent_id"
     column_type    = "integer"
   },

    {
     column_name    = "resv_room_id"
     column_type    = "integer"
   },

    {
     column_name    = "resv_rate_plan_id"
     column_type    = "integer"
   },

    {
     column_name    = "resv_rate_category_id"
     column_type    = "integer"
   },

    {
     column_name    = "market_id"
     column_type    = "integer"
   },

    {
     column_name    = "resv_booking_source_id"
     column_type    = "integer"
   },

    {
     column_name    = "channel_id"
     column_type    = "integer"
   },

    {
     column_name    = "travel_agent_id"
     column_type    = "integer"
   },

    {
     column_name    = "account_id"
     column_type    = "integer"
   },

    {
     column_name    = "length_of_stay_id"
     column_type    = "integer"
   },

    {
     column_name    = "pace_id"
     column_type    = "integer"
   },

    {
     column_name    = "resv_purpose_id"
     column_type    = "integer"
   },

    {
     column_name    = "resv_privateline_id"
     column_type    = "integer"
   },

    {
     column_name    = "entry_property_id"
     column_type    = "integer"
   },

    {
     column_name    = "resv_flag_id"
     column_type    = "integer"
   },

    {
     column_name    = "arrival_dt"
     column_type    = "timestamp without time zone"
   },

    {
     column_name    = "departure_dt"
     column_type    = "timestamp without time zone"
   },

    {
     column_name    = "cancellation_dt"
     column_type    = "timestamp without time zone"
   },

    {
     column_name    = "shr_idx"
     column_type    = "integer"
   },

    {
     column_name    = "num_rooms"
     column_type    = "integer"
   },

    {
     column_name    = "room_nights"
     column_type    = "integer"
   },

    {
     column_name    = "calc_nights_num"
     column_type    = "integer"
   },

    {
     column_name    = "direct_nights_num"
     column_type    = "integer"
   },

    {
     column_name    = "revenue"
     column_type    = "numeric"
   },

    {
     column_name    = "revenue_usd"
     column_type    = "numeric"
   },

    {
     column_name    = "pms_origin"
     column_type    = "integer"
   },

    {
     column_name    = "adult_num"
     column_type    = "integer"
   },

    {
     column_name    = " children_num"
     column_type    = "integer"
   },

    {
     column_name    = "last_chg_dt"
     column_type    = "timestamp without time zone"
   },

    {
     column_name    = "diam_cc"
     column_type    = "integer"
   },

    {
     column_name    = "ins_batch_id"
     column_type    = "integer"
   },

    {
     column_name    = "reservation_id"
     column_type    = "integer"
   },

    {
     column_name    = "vip_status"
     column_type    = "character varying"
   },

    {
     column_name    = "user_dept"
     column_type    = "character varying"
   },

    {
     column_name    = "entry_tm"
     column_type    = "character varying"
   },

    {
     column_name    = "hold_info"
     column_type    = "character varying"
   },

    {
     column_name    = "phone_ind"
     column_type    = "character varying"
   },

    {
     column_name    = "business_column_name"
     column_type    = "character varying"
   },

    {
     column_name    = "member_status"
     column_type    = "character varying"
   },

    {
     column_name    = "city"
     column_type    = "character varying"
   },

    {
     column_name    = "state"
     column_type    = "character varying"
   },

    {
     column_name    = "zip_cd"
     column_type    = "character varying"
   },

    {
     column_name    = "guest_country"
     column_type    = "character varying"
   },

    {
     column_name    = "country_cd"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd1"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd2"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd3"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd4"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd5"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd6"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd7"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd8"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd9"
     column_type    = "character varying"
   },

    {
     column_name    = "req_cd10"
     column_type    = "character varying"
   },

    {
     column_name    = "eta"
     column_type    = "character varying"
   },

    {
     column_name    = "usr_src_cd"
     column_type    = "character varying"
   },

    {
     column_name    = "cnsrt_cd"
     column_type    = "character varying"
   },

    {
     column_name    = "edw_hash_key"
     column_type    = "character varying"
   },

    {
     column_name    = "air_rate_category_cd"
     column_type    = "character varying"
   },

    {
     column_name    = "nt_rate"
     column_type    = "character varying"
   },

    {
     column_name    = "pms_rate_category_cd"
     column_type    = "character varying"
   },

    {
     column_name    = "day_cd"
     column_type    = "character varying"
   },

    {
     column_name    = "currency_cd"
     column_type    = "character varying"
   },

    {
     column_name    = "rec_loc"
     column_type    = "character varying"
   },

    {
     column_name    = "account_cd"
     column_type    = "character varying"
   },

    {
     column_name    = "offer_first_letter"
     column_type    = "character varying"
   },

    {
     column_name    = "lang_pref"
     column_type    = "character varying"
   },

    {
     column_name    = "title"
     column_type    = "character varying"
   },
]

#tags
tags_environment            = "dev"
tags_project                = "project"
tags_department             = "dept"
tags_department_data_owner  = "owner"