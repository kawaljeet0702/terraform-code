resource "null_resource" "create-endpoint" {
  provisioner "local-exec" {
    command = "aws personalize create-schema --no-verify-ssl --name ${var.schemaname} --schema file://files/${var.schemafilename} > ${data.template_file.log_name.rendered}"
    #command = "aws route53resolver create-resolver-endpoint --no-verify-ssl --creator-request-id ${var.creator-request-id} --security-group-ids ${local.security-groups} --direction ${var.direction} --ip-addresses ${local.list-ip-template} --name ${var.endpoint-name} --tags ${var.tags} --profile ${var.aws-profile} > ${data.template_file.log_name.rendered}"
    }
}

resource "null_resource" "backup-output" {
  provisioner "local-exec" {
    command = "aws s3 cp --no-verify-ssl output.log s3://xxx/dev-personalize-statefiles/"
    #command = "aws route53resolver create-resolver-endpoint --no-verify-ssl --creator-request-id ${var.creator-request-id} --security-group-ids ${local.security-groups} --direction ${var.direction} --ip-addresses ${local.list-ip-template} --name ${var.endpoint-name} --tags ${var.tags} --profile ${var.aws-profile} > ${data.template_file.log_name.rendered}"
    }
  depends_on = [null_resource.create-endpoint]
}

resource "null_resource" "output-id" {
  provisioner "local-exec" {
   #command = "aws route53resolver list-resolver-endpoints --no-verify-ssl --profile ${var.aws-profile} --output text --query 'ResolverEndpoints[?Name==`${var.endpoint-name}`].Id' > ${data.template_file.endpoint-id.rendered}"
   command = "aws personalize list-schemas --no-verify-ssl --output text --query schemas[?name=='${var.schemaname}'].schemaArn> ${data.template_file.schema-id.rendered}"
   #command = "aws s3 ls --output text --no-verify-ssl"
  }
  depends_on = [null_resource.create-endpoint]
}

resource "null_resource" "backup-id" {
  provisioner "local-exec" {
   #command = "aws route53resolver list-resolver-endpoints --no-verify-ssl --profile ${var.aws-profile} --output text --query 'ResolverEndpoints[?Name==`${var.endpoint-name}`].Id' > ${data.template_file.endpoint-id.rendered}"
   command = "aws s3 cp --no-verify-ssl id.log s3://xxx/dev-personalize-statefiles/"
   #command = "aws s3 ls --output text --no-verify-ssl"
  }
  depends_on = [null_resource.output-id]
}

resource "null_resource" "retrieve-id" {
  count = (var.delete != "false") ? 1 :0
  provisioner "local-exec" {
    #command = "aws route53resolver delete-resolver-endpoint resolver-endpoint-id ${trimspace(data.local_file.readId.content)} --profile ${var.aws-profile} > ${data.template_file.log_name.rendered}"
    command = "aws s3 cp --no-verify-ssl s3://xxx/dev-personalize-statefiles/id.log id.log"
  }
  depends_on = [null_resource.create-endpoint]
}

resource "null_resource" "sleep-1" {
  count = (var.delete != "false") ? 1 :0
  provisioner "local-exec" {
    #command = "aws route53resolver delete-resolver-endpoint resolver-endpoint-id ${trimspace(data.local_file.readId.content)} --profile ${var.aws-profile} > ${data.template_file.log_name.rendered}"
    command = "sleep 5s"
  }
  depends_on = [null_resource.retrieve-id]
}

resource "null_resource" "deleteEndpoint" {
  count = (var.delete != "false") ? 1 :0
  provisioner "local-exec" {
    #command = "aws route53resolver delete-resolver-endpoint resolver-endpoint-id ${trimspace(data.local_file.readId.content)} --profile ${var.aws-profile} > ${data.template_file.log_name.rendered}"
    command = "aws personalize delete-schema --no-verify-ssl --schema-arn ${trimspace(data.local_file.readId.content)} > ${data.template_file.log_name.rendered}"
  }
  depends_on = [null_resource.sleep-1]
}

# ------------------------------------------------------------
data "template_file" "log_name" {
  template = "${path.module}/output.log"
}

data "template_file" "schema-id" {
  template = "${path.module}/id.log"
}

data "local_file" "create-endpoint" {
  filename   = "${data.template_file.log_name.rendered}"
  depends_on = [null_resource.create-endpoint]
}

data "local_file" "readId" {
  filename   = "${data.template_file.schema-id.rendered}"
  depends_on = [null_resource.output-id]
}

data "template_file" "ip-template" {
  count    = "${length(var.subnet-ids)}"
  template = "SubnetId=${var.subnet-ids[count.index]},Ip=${var.ip_addresses[count.index]} "
}

data "template_file" "security-groups" {
  count    = "${length(var.security-groups)}"
  template = "${var.security-groups[count.index]} "
}

#------------------------------------------------------------------
locals {
  list-ip-template = "${join(" ",data.template_file.ip-template.*.rendered)}"
  security-groups  = "${join(" ",data.template_file.security-groups.*.rendered)}"
}