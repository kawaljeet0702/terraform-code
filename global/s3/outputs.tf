//
// module: s3
//

output "s3_id" {
  value = aws_s3_bucket.bucket.*.id
}

output "s3_arn" {
  value = aws_s3_bucket.bucket.*.arn
}

output "s3_bucket_domain_name" {
  value = aws_s3_bucket.bucket.*.bucket_domain_name
}