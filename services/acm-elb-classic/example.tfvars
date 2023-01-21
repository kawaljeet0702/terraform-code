#General
region            ="us-east-1"
#environment has to be either "dev", "stage" or "prod"
environment       ="dev"

certificate_domain_name = "service.example.com"
# Validation via DNS OR Email
validation_method   = "DNS"
public_zone_name    ="example.com"



# ELB 
#classic elb
elb_name            = "test-elb"
subnets             = ["subnet-34324","subnet-234235","subnet-14324"]
security_groups     = ["sg-032"]

#listener configuration (comment the lines as shown below if not required)
listener = [
        {
            instance_port     = 8000
            instance_protocol = "http"
            lb_port           = 80
            lb_protocol       = "http"
        },
        /*{
            instance_port      = 8000
            instance_protocol  = "http"
            lb_port            = 443
            lb_protocol        = "https"
        },*/
]

#listener with ssl certificate configuration (comment the lines as shown above if not required)
listener_with_certificate = [
        {
            instance_port      = 8000
            instance_protocol  = "http"
            lb_port            = 443
            lb_protocol        = "https"
            ssl_certificate_id = "arn:aws:iam::xxx:server-certificate/certName"
        },
]

#access_logs optional configuration (comment the lines as shown above if not required)
access_logs = [
        {
            bucket        = "bucketname"
            bucket_prefix = "prefix"
            interval      = 60
        },
]

#health_check optional configuration (comment the lines as shown above if not required)
health_check = [
        /*{
            healthy_threshold   = 2
            unhealthy_threshold = 2
            timeout             = 3
            target              = "HTTP:8000/"
            interval            = 30
        },*/
]

#optional settings (comment the line if not needed)
instances                   = ["i-0"]
cross_zone_load_balancing   = true
idle_timeout                = 400
connection_draining         = true
connection_draining_timeout = 400

#Tags
tags_environment            ="dev"
tags_project                ="project"
tags_department             ="department"
tags_department_data_owner  ="owner"