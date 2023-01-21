variable "region" {
  default = "us-east-1"
}

variable "alarm_name" {
}

variable "comparison_operator" {
}

variable "evaluation_periods" {
}

variable "metric_name" {
}

variable "namespace" {
}

variable "period" {
}

variable "statistic" {
}

variable "threshold" {
}

variable "alarm_description" {
}

variable "alarm_actions" {
}

variable "ok_actions" {
}

variable "dimensions" {
  type = map(string)
}