import json
import boto3
import re
import os

ec2 = boto3.client('elbv2', region_name='us-east-1')
ssm = boto3.client("ssm")
alb_tg_arn ="arn:aws:elasticloadbalancing:us-east-1:111352766985:targetgroup/TG1/51999f3993d2c93c"
alb_tg_hotstandby_arn = "arn:aws:elasticloadbalancing:us-east-1:111352766985:targetgroup/TG2/baeb2052cca31046"
rule_arn = "arn:aws:elasticloadbalancing:us-east-1:111352766985:listener-rule/app/TGfailover/23ad68ea31d5e565/e226709cb1e3d73d/4c93be3f454f3378"
def lambda_handler(context, event):


    health_default=get_tg_health(alb_tg_arn)           
    print('default tg health=' + health_default)
    
    health_standby=get_tg_health(alb_tg_hotstandby_arn)  
    print('standby tg health=' + health_standby)
    
    standby=get_tg_instance(alb_tg_hotstandby_arn)
    print('standby instance id=' + standby)
    

    
    
    if (health_default == 'unhealthy'):
      assign_tg(rule_arn,alb_tg_arn,alb_tg_hotstandby_arn)
      ssm.send_command(
      InstanceIds=[standby],
      DocumentName="AWS-RunShellScript",
      Parameters={
            "commands": ["sudo systemctl start nginx.service"]
            } 
        )
        
    elif (health_default == 'healthy'):
      assign_tg_revert(rule_arn,alb_tg_arn,alb_tg_hotstandby_arn)
      ssm.send_command(
      InstanceIds=[standby],
      DocumentName="AWS-RunShellScript",
      Parameters={
            "commands": ["sudo systemctl stop nginx.service"]
            } 
        )
      print("target group {} is healthy now".format(alb_tg_arn))
      
      return [health_default, health_standby, standby]


    
def get_tg_health(tg_arn):

    client = boto3.client('elbv2')
    print('get health status of TG:' + tg_arn)
    response = client.describe_target_health(
        TargetGroupArn=tg_arn
    )
    print(response)
    
    for item in (response["TargetHealthDescriptions"]):
        health = item["TargetHealth"]["State"]
        print('HEALTH=' + str(health))
        return health
        
        
def get_tg_instance(tg_arn):

    client = boto3.client('elbv2')
    print('get health status of TG:' + tg_arn)
    response = client.describe_target_health(
        TargetGroupArn=tg_arn
    )

    print(response)
    for item in (response["TargetHealthDescriptions"]):
        instance = item["Target"]["Id"]
        health = item["TargetHealth"]["State"]
        print('INSTANCE=' + str(instance))
        return instance        
        
        

        
def assign_tg(rule_arn,alb_tg_arn,alb_tg_hotstandby_arn):
    ec2.modify_rule(
        RuleArn=rule_arn,
        Actions=[
          {
            'Type': 'forward',
            'ForwardConfig': {
              'TargetGroups': [
                {
                  'TargetGroupArn': alb_tg_arn,
                  'Weight': 0
                },
                {
                  'TargetGroupArn': alb_tg_hotstandby_arn,
                  'Weight': 100
                }
              ]
            }
          }
        ]
    )
    
def assign_tg_revert(rule_arn,alb_tg_arn,alb_tg_hotstandby_arn):
    ec2.modify_rule(
        RuleArn=rule_arn,
        Actions=[
          {
            'Type': 'forward',
            'ForwardConfig': {
              'TargetGroups': [
                {
                  'TargetGroupArn': alb_tg_arn,
                  'Weight': 100
                },
                {
                  'TargetGroupArn': alb_tg_hotstandby_arn,
                  'Weight': 0
                }
              ]
            }
          }
        ]
    )