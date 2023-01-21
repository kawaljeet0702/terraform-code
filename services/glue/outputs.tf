output "CatalogID_and_name_of_the_database" {
  value = [aws_glue_catalog_database.aws_glue_catalog_database.*.id]
}

output "CatalogID_and_name_of_the_postgres_connection" {
  value = [aws_glue_connection.ods-postgres.*.id]
}

output "atalogID_and_name_of_the_redshift_connection" {
  value = [aws_glue_connection.tspoc-dev.*.id]
}

output "Postgres_Crawler_name" {
  value = [aws_glue_crawler.postgres-crawler.*.id]
}

output "Redshift_Crawler_name" {
  value = [aws_glue_crawler.redshift-crawler.*.id]
}