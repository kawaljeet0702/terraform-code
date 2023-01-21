variable "region" {
}

variable "create_workgroup" {
  default = false
}

variable "create_db" {
  default = false
}

variable "create_query" {
  default = false
}

variable "workgroup_name" {
  default = false
}

variable "query_name" {
  default = ""
}

variable "workgroup_description" {
  default = false
}

variable "replication_configuration" {
    type = list(object({
      replication_role_arn   = string
      replication_id     = string
      replication_bucket_arn    = string
      destination_storage_class = string
    }))
}

variable "bucket_arn" {
  type = string
  default =""
}

variable "existing_db_name" {
  type = string
  default =""
}

variable "exisiting_workgroup_name" {
  type = string
  default =""
}

variable "query" {
  type = string
  default =""
}

variable "bucketname" {
  type = map(string)
}

variable "bucket_acls" {
  type    = list(string)
  default = ["private"]
}

variable "versioning_enabled" {
  type        = string
  default     = true
  description = "Enable versioning. Versioning is a means of keeping multiple variants of an object in the same bucket."
}

variable "objectlock_enabled" {
  type    = string
  default = "Disabled"
}

variable "sse_algorithm" {
  default = "AES256"
}

variable "enable_replcation" {
  default = false
}

variable "key_arn" {
  default = ""
}

variable "create_s3" {
  default = false
}

variable "database_name" {
}

variable "environment" {
  default = ""
}

variable "replication_role_arn" {
  default = ""
}

variable "replication_id" {
  default = ""
}

variable "replication_bucket_arn" {
  default = ""
}

variable "destination_storage_class" {
  default = ""
}

variable "enable_30_30" {
  default = false
}

variable "enable_30" {
  default = false
}

variable "policy_filename" {
  default = ""
}

variable "attach_policy" {
  default = false
}

variable "block_public_policy" {
  default = true
}

variable "block_public_acls" {
  default = true
}

variable "ignore_public_acls" {
  default = true
}

variable "restrict_public_buckets" {
  default = true
}

variable "force_destroy" {
  default = false
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