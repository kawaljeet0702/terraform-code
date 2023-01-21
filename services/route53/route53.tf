// Module to add Public Zone in Route53.
resource "aws_route53_zone" "public" {
    name        = var.zone_name
    comment     = var.comment
    
    tags = {
    Name                      = lower(var.tags_name)
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = upper(var.tags_department_data_owner)
    "Terraform Managed"       = lower(var.tags_terraform_managed)
   }
}