//
// module: s3
//

output "s3_id" {
  value = aws_s3_bucket.bucket[0].id
}

output "s3_arn" {
  value = aws_s3_bucket.bucket[0].arn
}

output "s3_bucket_domain_name" {
  value = aws_s3_bucket.bucket[0].bucket_domain_name
}