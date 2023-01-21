resource "aws_lb" "applicationlb" {
  count              = var.create_applicationlb ? 1 :0
  name               = var.applicationlb_name
  internal           = var.applicationlb_internal
  load_balancer_type = "application"
  security_groups    = var.applicationlb_security_groups
  subnets            = var.applicationlb_subnets

  enable_deletion_protection = var.applicationlb_enable_deletion_protection

  dynamic "access_logs" {
    for_each = var.applicationlb_access_logs
    content{
        bucket        = access_logs.value.applicationlb_bucket
        prefix        = access_logs.value.applicationlb_bucket_prefix
        enabled       = access_logs.value.applicationlb_enabled
    }
  }

  tags = {
    Name                    = "${var.applicationlb_name}"
    Environment             = "${var.tags_environment}"
    Project                 = "${var.tags_project}"
    Department              = "${var.tags_department}"
    "Department Data Owner" = "${var.tags_department_data_owner}"
  }
}

resource "aws_lb" "networklb" {
  count              = var.create_networklb ? 1 :0
  name               = var.networklb_name
  internal           = var.networklb_internal
  load_balancer_type = "network"
  subnets            = var.networklb_subnets

  enable_deletion_protection = var.networklb_enable_deletion_protection

  dynamic "access_logs" {
    for_each = var.networklb_access_logs
    content{
        bucket        = access_logs.value.networklb_bucket
        prefix        = access_logs.value.networklb_bucket_prefix
        enabled       = access_logs.value.networklb_enabled
    }
  }

  tags = {
    Name                    = "${var.networklb_name}"
    Environment             = "${var.tags_environment}"
    Project                 = "${var.tags_project}"
    Department              = "${var.tags_department}"
    "Department Data Owner" = "${var.tags_department_data_owner}"
  }
}

resource "aws_lb_target_group" "instance_group" {
    count                = var.target_type == "instance" ? 1 : 0
    name_prefix          = var.name_prefix
    port                 = var.port
    protocol             = var.protocol
    vpc_id               = var.vpc_id
    deregistration_delay = 300
    stickiness {
        type            = "lb_cookie"
        cookie_duration = 86400
        enabled         = var.enable_stickiness ? true : false
    }
    health_check {
        interval            = var.health_check_interval
        path                = var.health_check_path
        port                = "traffic-port"
        protocol            = var.health_check_protocol
        timeout             = var.health_check_timeout
        healthy_threshold   = var.health_check_healthy_threshold
        unhealthy_threshold = var.unhealthy_threshold
        matcher             = var.matcher
    }
    tags = {
    Name                    = "${var.networklb_name}"
    Environment             = "${var.tags_environment}"
    Project                 = "${var.tags_project}"
    Department              = "${var.tags_department}"
    "Department Data Owner" = "${var.tags_department_data_owner}"
  }
}

resource "aws_lb_target_group" "ip_group" {
    count                = var.target_type == "ip" ? 1 : 0
    name_prefix          = var.name_prefix
    target_type          = "ip"
    port                 = var.port
    protocol             = var.protocol
    vpc_id               = var.vpc_id
    deregistration_delay = 300
    stickiness {
        type            = "lb_cookie"
        cookie_duration = 86400
        enabled         = var.enable_stickiness ? true : false
    }
    health_check {
        interval            = var.health_check_interval
        path                = var.health_check_path
        port                = "traffic-port"
        protocol            = var.health_check_protocol
        timeout             = var.health_check_timeout
        healthy_threshold   = var.health_check_healthy_threshold
        unhealthy_threshold = var.unhealthy_threshold
        matcher             = var.matcher
    }
    tags = {
    Name                    = "${var.networklb_name}"
    Environment             = "${var.tags_environment}"
    Project                 = "${var.tags_project}"
    Department              = "${var.tags_department}"
    "Department Data Owner" = "${var.tags_department_data_owner}"
  }
}

resource "aws_lb_listener" "listener_forward_action" {
    count             = var.enable_forwardactionlistener ? 1 : 0
    load_balancer_arn = aws_lb.applicationlb[0].arn
    port              = var.port
    protocol          = var.protocol
    ssl_policy        = var.ssl_policy
    certificate_arn   = var.certificate_arn
    default_action {
       target_group_arn = aws_lb_target_group.instance_group[0].arn
       type             = "forward"
    }
}

resource "aws_lb_listener" "nlb_listener" {
  count             = var.enable_nlblistener ? 1 : 0
  load_balancer_arn = aws_lb.networklb[0].arn
  port              = var.port
  protocol          = var.protocol
  certificate_arn   = var.certificate_arn
  alpn_policy       = "HTTP2Preferred"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip_group[0].arn
  }
}

resource "aws_lb_target_group_attachment" "instance" {
  target_group_arn = aws_lb_target_group.instance_group[0].arn
  target_id        = var.target_id
  port             = var.target_port
}