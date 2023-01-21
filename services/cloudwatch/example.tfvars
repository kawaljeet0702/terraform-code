#general
region              = "us-east-1"

alarm_name          = "cpu_utilization_too_high"

#The arithmetic operation to use when comparing the specified Statistic and Threshold. 
#The specified Statistic value is used as the first operand. 
#Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold. 
#Additionally, the values LessThanLowerOrGreaterThanUpperThreshold, LessThanLowerThreshold, and GreaterThanUpperThreshold are used only for alarms based on anomaly detection models.
comparison_operator = "GreaterThanThreshold"

#The number of periods over which data is compared to the specified threshold.
evaluation_periods  = "1"

#The name for the alarm's associated metric
metric_name         = "CPUUtilization"

#for complete list of namespace follow the link below
#https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
#for ec2 use AWS/EC2
#for rds use AWS/RDS
namespace           = "AWS/RDS"

#The period in seconds over which the specified statistic is applied.
period              = "600"

#The statistic to apply to the alarm's associated metric. 
#Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum
statistic           = "Average"

#The value against which the specified statistic is compared.
threshold           = "50"

alarm_description   = "Average database CPU utilization over last 10 minutes too high"

#he list of actions to execute when this alarm transitions into an ALARM state from any other state.
alarm_actions       = ["arn:aws:sns:us-east-1:xxx:cloudwatch_sns_db"]

#The list of actions to execute when this alarm transitions into an OK state from any other state.
ok_actions          = ["arn:aws:sns:us-east-1:xxx:cloudwatch_sns_db"]

dimensions = {
#for instance use InstanceId
#"InstanceId" = "i-332432"
#for DB use DBInstanceIdentifier
"DBInstanceIdentifier" = "dsdwe2"
}