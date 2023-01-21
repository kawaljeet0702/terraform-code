//
// Module: sg
//

output "sg_id" {
  value = element(concat(aws_security_group.sg.*.id, [""]), 0)
}

