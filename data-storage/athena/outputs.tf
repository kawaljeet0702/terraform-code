//
// Module: eni
//

output "athena_db" {
  value = [aws_athena_database.db.*.name]
}

output "athena_workgroup" {
  value = [aws_athena_workgroup.workgroup.*.name]
}