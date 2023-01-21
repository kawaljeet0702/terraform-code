terraform {
  backend "s3" {
    bucket               = "h-terraform-state-analytics-dev"
    key                  = "devterraform.tfstate"
    workspace_key_prefix = "datateam/workspaces"
    dynamodb_table       = "hyatt-terraform-state-lock-dynamo"
    region               = "us-east-1"
  }
}