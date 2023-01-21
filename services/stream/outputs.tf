//
// Module: stream
//

output "stream_arn" {
  #value = concat(aws_kinesis_stream.kinesis_stream[0].id, [""])
  value = element(concat(aws_kinesis_stream.kinesis_stream.*.id, [""]), 0)
}