variable "shard_count" {
  description = "The number of shards that the stream will use."
  //  Amazon has guidelines for specifying the Stream size that should be referenced when creating a Kinesis stream.
  //  See [Amazon Kinesis Streams](https://docs.aws.amazon.com/streams/latest/dev/amazon-kinesis-streams.html) for more.
}

variable "encryption_type" {
}

variable "kms_key_alias_arn" {
  default = ""
}

variable "arn" {
}

variable "region" {
}

variable "retention_period" {
  description = "Length of time data records are accessible after they are added to the stream."
  default     = "24"
  //  The maximum value of a stream's retention period is 168 hours. Minimum value is 24."
}

variable "shard_level_metrics" {
  type        = list(string)
  description = "A list of shard-level CloudWatch metrics which can be enabled for the stream."
  default     = ["IncomingBytes", "OutgoingBytes"]
  //  See [Monitoring with CloudWatch](https://docs.aws.amazon.com/streams/latest/dev/monitoring-with-cloudwatch.html)
  // for more. Note that the value ALL should not be used; instead you should provide an explicit list of metrics you
  // wish to enable."
}

variable "startindex" {
  default = 0
}

variable "create_stream" {
  default = false
}


// Tags 

variable "tags_environment" {
  description = "(Mandatory)Used to distinguish between development, test, and production infrastructure"
  type        = string
}

variable "tags_name" {
  description = "(Mandatory)A cosmetic, compound tag used to help identify, sort, group, and troubleshoot resources in AWS consoles,etc. and <region using>-<short environment name>-<short app name>-<short app tier>)."
  type        = string
}

variable "tags_project" {
  description = "(Optional)Used to identify the project(s) the resource supports."
  type        = string
}

variable "tags_department" {
  description = "(Mandatory)Used to identify the department associated with the resource"
  type        = string
}

variable "tags_department_data_owner" {
  description = "(Mandatory)Used to identify the department associated with the dataowner"
  type        = string
}