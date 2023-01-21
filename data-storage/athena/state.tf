terraform {
  backend "s3" {
    bucket               = "xxxv"
    key                  = "devterraform.tfstate"
    workspace_key_prefix = "team/workspaces"
    dynamodb_table       = "state-lock-dynamo-table"
    region               = "us-east-1"
  }
}