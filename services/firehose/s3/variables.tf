variable "create_s3" {
  default = false
}

variable "region" {
}

variable "bucketname" {
  type = string
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