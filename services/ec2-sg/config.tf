/*
resource "aws_security_group_rule" "ingress" {
  count             = var.enable_sg ? length(var.ingress_rules) : 0
  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_blocks]
  security_group_id = aws_security_group.sg[0].id
}
*/
/*
resource "aws_security_group_rule" "misc-ingress" {
  count             = var.enable_sg ? length(keys(var.misc_from_to_ports_map)) : 0
  type              = "ingress"
  from_port         = element(keys(var.misc_from_to_ports_map), count.index)
  to_port           = var.misc_from_to_ports_map[element(keys(var.misc_from_to_ports_map), count.index)]
  protocol          = "tcp"
  cidr_blocks       = var.misc_cidr_blocks
  security_group_id = aws_security_group.sg[0].id
}
*/
/*
resource "aws_security_group_rule" "egress" {
  count             = var.enable_sg ? length(var.egress_rules) : 0
  type              = "egress"
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = [var.egress_rules[count.index].cidr_blocks]
  security_group_id = aws_security_group.sg[0].id

  lifecycle {
  create_before_destroy = false
  }
}
*/
/*
resource "aws_security_group_rule" "self_reference" {
  count             = var.enable_sg ? 1 : 0
  type              = "ingress"
  from_port         = "0"
  to_port           = "65535"
  protocol          = "all"
  self              = "true"
  security_group_id = aws_security_group.sg[0].id
}
*/
/* 
resource "aws_security_group_rule" "mgmt_inbound" {
  count                    = var.enable_sg ? 1 : 0
  type                     = "ingress"
  from_port                = "0"
  to_port                  = "65535"
  protocol                 = "all"
  source_security_group_id = var.mgmt_sg_id
  security_group_id        = aws_security_group.sg[0].id
}
 */
resource "aws_security_group_rule" "bastion_ingress" {
  count                    = var.enable_sg ? length(keys(var.bastion_inbound_from_to_ports_map)) : 0
  type                     = "ingress"
  from_port                = element(keys(var.bastion_inbound_from_to_ports_map), count.index)
  to_port                  = var.bastion_inbound_from_to_ports_map[element(keys(var.bastion_inbound_from_to_ports_map), count.index)]
  protocol                 = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id        = aws_security_group.sg[0].id
}

/*
// sg-ingress-to-instances resource is enabled only for sg-rules datafile. This rule gets created whenever there is a source security group 
resource "aws_security_group_rule" "sg-ingress-to-instances" {
  //count                  = var.enable_inbound ? length(keys(var.security_group_id)) : 0
  count                    = var.enable_inbound ? length(var.sg_ingress_rules) : 0
  type                     = "ingress"
  from_port                = var.sg_ingress_rules[count.index].from_port
  to_port                  = var.sg_ingress_rules[count.index].to_port
  protocol                 = "tcp"
  source_security_group_id = var.sg_ingress_rules[count.index].source_security_group_id
  security_group_id        = aws_security_group.sg[0].id
  //security_group_id      = var.security_group_id[count.index]
}
*/
 
/* 
resource "aws_security_group_rule" "ip-ingress-to-instances" {
  count             = var.enable_inboundip ? length(keys(var.security_group_id)) : 0
  type              = "ingress"
  from_port         = element(keys(var.inbound_from_to_ports_map), count.index)
  to_port           = var.inbound_from_to_ports_map[element(keys(var.inbound_from_to_ports_map), count.index)]
  protocol          = "tcp"
  cidr_blocks       = var.sg_cidr_blocks
  security_group_id = var.security_group_id[count.index]
}
*/
 