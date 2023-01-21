// Module VPC Network ACL's. 
resource "aws_network_acl" "all" {
  vpc_id = var.vpc_id
  # Attach Subnets to ACL. 
  subnet_ids = var.subnet_id


  dynamic "ingress" {
    for_each = [for nacl in var.ingress_nacls : {
      rule_no    = nacl[0]
      protocol   = nacl[1]
      action     = nacl[2]
      cidr_block = nacl[3]
      from_port  = nacl[4]
      to_port    = nacl[5]
    }]

    content {
      rule_no    = ingress.value.rule_no
      protocol   = ingress.value.protocol
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = [for nacl in var.egress_nacls : {
      rule_no    = nacl[0]
      protocol   = nacl[1]
      action     = nacl[2]
      cidr_block = nacl[3]
      from_port  = nacl[4]
      to_port    = nacl[5]
    }]

    content {
      rule_no    = egress.value.rule_no
      protocol   = egress.value.protocol
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }
  tags = {
    Name                      = lower(var.tags_name)
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = upper(var.tags_department_data_owner)
    "Terraform Managed"       = lower(var.tags_terraform_managed)
   }
}