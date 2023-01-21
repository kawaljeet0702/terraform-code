# AWS Glue
###############################

data "local_file" "rs_username" {
    filename = var.redshift_username
}
 
data "local_file" "rs_password" {
    filename = var.redshift_password
}
 
data "local_file" "pg_username" {
    filename = var.postgres_username
}
 
data "local_file" "pg_password" {
    filename = var.postgres_password
}

resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
      count       = var.enable_database ? 1 : 0
      name        = var.databasename
      description = var.description
    }
 
  resource "aws_glue_catalog_table" "aws_glue_s3_catalog" {
      name = var.tablename
      count = var.s3_catalog_table ? (var.enable_s3 ? 1 : 0 ): 0
      database_name = var.databasename
      depends_on = [aws_glue_catalog_database.aws_glue_catalog_database]
      table_type = var.table_type
      retention = var.retention

      parameters = {
        EXTERNAL              = var.external_type
        "parquet.compression" = var.parquet_compression
      }

      storage_descriptor {
        location = var.s3_bucket
        input_format  = var.input_format
        output_format = var.output_format
        compressed    = var.compressed
        parameters = {
            "crawler_schema_serializer_version" = var.crawler_schema_serializer_version
            "crawler_schema_deserializer_version" = var.crawler_schema_deserializer_version
            "compression_type" = var.compression_type
            "classification" = var.classification     
            "typeOfData" = var.typeofdata
            "streamName" = var.streamname
            "kinesisUrl" = var.kinesisurl
        }
        ser_de_info {
          name                  = var.ser_de_info
          serialization_library = var.serialization_library
          parameters = {
            "serialization.format" = var.serialization_format
          }
        }
          dynamic "columns" {
              for_each = var.columns
              content{
                  name         = columns.value.column_name
                  type         = columns.value.column_type
              }
            }
      }
    }
 
 resource "aws_glue_catalog_table" "aws_glue_redshift_catalog" {
      name = var.tablename
      count= var.redshift_catalog_table ? (var.enable_redshift ? 1 : 0 ): 0
      database_name = var.databasename
      depends_on = [aws_glue_catalog_database.aws_glue_catalog_database]
      table_type = var.table_type
      retention = var.retention
      parameters = {
        EXTERNAL              = var.external_type
        "parquet.compression" = var.parquet_compression
      }
      storage_descriptor {
        location = var.redshift_location
        input_format  = var.input_format
        output_format = var.output_format
        compressed    = var.compressed
        parameters = {
            "crawler_schema_serializer_version" = var.crawler_schema_serializer_version
            "crawler_schema_deserializer_version" = var.crawler_schema_deserializer_version
            "compression_type" = var.compression_type
            "classification" = var.classification
            "typeOfData" = var.typeofdata
            "streamName" = var.streamname
            "kinesisUrl" = var.kinesisurl
        }
        ser_de_info {
          name                  = var.ser_de_info
          serialization_library = var.serialization_library
          parameters = {
            "serialization.format" = var.serialization_format
          }
        }
      }
      /*dynamic "columns" {
        for_each = var.columns
        content{
            name         = columns.value.column_name
            type         = columns.value.column_type
        }
      }*/
  }

resource "aws_glue_crawler" "postgres-crawler" {
  count             = var.enable_postgres_crawler ? 1 : 0
  database_name = var.postgres_database
  name          =  var.postgres_crawler 
  role          =  var.role_arn
  schedule      = var.postgres_cron
 
  jdbc_target {
   connection_name = var.postgres_connection_name
    path            = var.postgres_path
  }
}

resource "aws_glue_crawler" "redshift-crawler" {
  count             = var.enable_redshift_crawler ? 1 : 0
  database_name = var.redshift_database
  name          =  var.redshift_crawler 
  role          =  var.role_arn
  schedule      = var.redshift_cron
  jdbc_target {
    connection_name = var.redshift_connection_name
    path            = var.redshift_path
  }
}

resource "aws_glue_connection" "ods-postgres" {
  count             = var.enable_postgres_connection ? 1 : 0
  name = var.postgres_name

  connection_properties = {
    JDBC_CONNECTION_URL = var.postgres_connection
    #USERNAME            = var.postgres_username
    #PASSWORD            = var.postgres_password
    USERNAME            = data.local_file.pg_username.content
    PASSWORD            = data.local_file.pg_password.content
  }

  physical_connection_requirements {
      availability_zone      = var.az_postgres
      security_group_id_list        = var.securitygroupid_postgres
      subnet_id = var.subnetid_postgres
    }
}

resource "aws_glue_connection" "tspoc-dev" {
  count             = var.enable_redshift_connection ? 1 : 0
  connection_properties = {
    JDBC_CONNECTION_URL = var.redshift_connection
    #USERNAME            = var.redshift_username
    #PASSWORD            = var.redshift_password
    USERNAME            = data.local_file.rs_username.content
    PASSWORD            = data.local_file.rs_password.content
    }

  name = var.redshift_name
  physical_connection_requirements {
    availability_zone      = var.az_redshift
    security_group_id_list        = var.securitygroupid_redshift
    subnet_id = var.subnetid_redshift
  }
}

###########Python Job########
resource "aws_glue_job" "dim_market_transfom" {
  name     = var.pythonjob
  role_arn = var.role_arn
  connections=var.postgres_connection_job
    command {
      script_location = var.postgres_script_location #"s3:/xxx/dim_market_transform.py"
    }
}

###########Python Job########
resource "aws_glue_job" "redshift-transform" {
  //name     = "sample-2"
  name     = var.redshiftjob
  role_arn = var.role_arn
  //connections=["dev"]
  connections=var.redshift_connection_job

  command {
    script_location = var.redshift_script_location #"s3://xxx/redshift-transformation/test_glue.py"
  }
}