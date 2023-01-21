variable "region" {
}

variable "input_format" {
}

variable "output_format" {
}

variable "env_name" {
}

variable "name" {
}

variable "table_type" {
}


variable "retention" {
}

variable "s3_bucket" {
}

variable "postgres_username" {
}

variable "postgres_password" {
}

variable "redshift_username" {
}

variable "redshift_password" {
}

variable "columns" {
}

variable "role_arn" {
}


variable "ser_de_info" {
}

variable "databasename" {
}

variable "postgres_connection" {
}

variable "redshift_connection" {
}

variable "enable_database" {
	default = false
}

variable "s3_catalog_table" {
	default = false
}

variable "redshift_catalog_table" {
	default = false
}

variable "enable_postgres_crawler" {
	default = false
}

variable "enable_redshift_crawler" {
	default = false
}

variable "securitygroupid_postgres" {
	type = list
	default = []
}

variable "enable_postgres_connection" {
	default = false
}

variable "enable_redshift_connection" {
	default = false
}

variable "enable_redshift" {
	default = false
}

variable "enable_s3" {
	default = false
}

variable "tablename" {
}


variable "redshift_script_location" {
}

variable "redshift_location" {
}

variable "postgres_name" {
}

variable "subnetid_postgres" {
}

variable "redshift_name" {
}

variable "az_redshift" {
}


variable "az_postgres" {
}

variable "subnetid_redshift" {
}

variable "securitygroupid_redshift" {
}

variable "postgres_database" {
}

variable "postgres_crawler" {
}

variable "postgres_connection_name" {
}

variable "postgres_path" {
}

variable "description" {
}

variable "redshift_database" {
}

variable "redshift_crawler" {
}

variable "redshift_connection_name" {
}

variable "redshift_path" {
}

variable "pythonjob" {
}

variable "redshiftjob" {
}

variable "postgres_connection_job" {
}

variable "redshift_connection_job" {
}

variable "postgres_script_location"{
}

variable "postgres_cron"{
}


variable "redshift_cron"{
}


variable "compression_type"{
}

variable "classification"{
}

variable "typeofdata"{
}

variable "streamname"{
}


variable "kinesisurl"{
}


variable "serialization_library"{
}

variable "serialization_format"{
}

variable "external_type"{
}

variable "parquet_compression"{
}

variable "compressed"{
}

variable "crawler_schema_serializer_version" {
}


variable "crawler_schema_deserializer_version" {
}

#tags
variable "tags_environment" {
}

variable "tags_project" {
}

variable "tags_department" {
}

variable "tags_department_data_owner" {
}