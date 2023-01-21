resource "aws_security_group" "sg" {
  count       = var.enable_sg ? 1 : 0
  name        = lower("${var.tags_name}${count.index + var.startindex}")
  description = lower(var.description)
  vpc_id      = var.vpc_id

  tags = {
    Name                      = lower("${var.tags_name}${count.index + var.startindex}")
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = lower(var.tags_department_data_owner)
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content{
        from_port         = egress.value.from_port
        to_port           = egress.value.to_port
        protocol          = egress.value.protocol
        cidr_blocks       = [egress.value.cidr_blocks]
        description       = egress.value.description
    }
  }

  dynamic "ingress" {
    for_each = var.ingress_rules
    content{
      from_port         = ingress.value.from_port
      to_port           = ingress.value.to_port
      protocol          = ingress.value.protocol
      cidr_blocks       = [ingress.value.cidr_blocks]
      description       = ingress.value.description
    }
  }

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content{
      from_port         = ingress.value.from_port
      to_port           = ingress.value.to_port
      protocol          = ingress.value.protocol
      security_groups   = [ingress.value.source_security_group_id]      
      description       = ingress.value.description
    }
  }

  ingress {
   from_port         = 0
   to_port           = 0
   protocol          = "-1"
   self              = "true"
   description       = "self"
  }

}

