#General
region            ="us-east-1"

certificate_domain_name = "dev.aws.com"
# Validation via DNS OR Email
validation_method   = "DNS"
public_zone_name    ="dev.aws.com"

#application lb
create_applicationlb                      = "true"
applicationlb_name                        = "edc"
applicationlb_internal                    = "true"
applicationlb_subnets                     = ["subnet-445","subnet-2434","subnet-4534"]
applicationlb_security_groups             = ["sg-3243"]
applicationlb_enable_deletion_protection  = "false"
#access_logs optional configuration (comment the lines if not required)
applicationlb_access_logs = [
        {
            applicationlb_bucket        = "xxx"
            applicationlb_bucket_prefix = ""
            applicationlb_enabled       = "true"
        },
]

#network lb
create_networklb                      = "false"
networklb_name                        = "testnlb"
networklb_internal                    = "true"
networklb_subnets                     = ["subnet-34234","subnet-34325","subnet-23425"]
networklb_enable_deletion_protection  = "true"
#access_logs optional configuration (comment the lines if not required)
networklb_access_logs = [
        /*{
            networklb_bucket          = "bucketname"
            networklb_bucket_prefix   = "prefix"
            networklb_enabled         = "true"
        },*/
]

#listener - Forward Action
enable_forwardactionlistener    = true
# URL for ssl policy https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html.
ssl_policy                      = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

#listener - To a NLB
enable_nlblistener              = false
alpn_policy                     = "HTTP2Preferred"

#listener common settings
port                            = 443
protocol                        = "HTTPS"

#target group
#target_type can be 'instance' or 'ip'
target_type                     = "instance"
name_prefix                     = "alb-"
vpc_id                          = "vpc-0a"
enable_stickiness               = false
health_check_interval           = 30
health_check_path               = "/"
health_check_protocol           = "HTTPS"
health_check_timeout            = 5
health_check_healthy_threshold  = 5
unhealthy_threshold             = 2
matcher                         = 200

#target group attachment
#target_id (Required) The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. 
#If the target type is ip, specify an IP address. If the target type is lambda, specify the arn of lambda.
target_id                       = ["i-0d", "i-0"]
target_port                     = 443

#Tags
tags_environment            ="dev"
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"
tags_terraform_managed      ="true"