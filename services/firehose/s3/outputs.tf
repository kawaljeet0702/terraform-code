//
// module: s3
//

output "s3_id" {
  #value = aws_s3_bucket.bucket[0].id
  value = element(concat(aws_s3_bucket.bucket.*.id, [""]), 0)
}

output "s3_arn" {
  #value = aws_s3_bucket.bucket[0].arn
  value = element(concat(aws_s3_bucket.bucket.*.arn, [""]), 0)
}

output "s3_bucket_domain_name" {
  #value = aws_s3_bucket.bucket[0].bucket_domain_name
  value = element(concat(aws_s3_bucket.bucket.*.bucket_domain_name, [""]), 0)
}