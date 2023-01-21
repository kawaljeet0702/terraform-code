#General
region                  ="us-east-1"
subnet_id               ="subnet-0b9,subnet-3234234,subnet-423reewr"
security_groups         ="sg-32423ew"
total_mount_on_each_efs =3

efsinfo= {
count               =2
startindex          =0
performance_mode    ="generalPurpose"
throughput_mode     ="bursting"
encrypted           =true
transition_to_ia    ="AFTER_90_DAYS"
kms_key_id          ="arn:aws:kms:us-east-1:xxx:key/xxx"
}

#Tags
tags_name                   ="name"
tags_environment            ="dev"
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"