#!/bin/bash

SG_ID="sg-052c3b183b107bf1d" # replace with your ID
AMI_ID="ami-0220d79f3f480ecf5"


 for instance in $@
do
    INSTANCE_ID=$( aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type "t3.micro" \
    --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query 'Instances[0].InstanceId' \
    --output text )
    done