import boto3
import json
import os
from botocore.exceptions import ClientError

REGION=os.environ.get('AWS_DEFAULT_REGION')
INSTANCE_ALIAS=os.environ.get('INSTANCE_ALIAS')

connect = boto3.client('connect')

def get_instance():
    instances = connect.list_instances()
    for instance in instances['InstanceSummaryList']:
        if instance['InstanceAlias'] == INSTANCE_ALIAS:
            id = instance['Id']
        return(id)

id = get_instance()
try:
    response = connect.delete_instance(
        InstanceId=id
    )
    print(response)
except ClientError as e:
    print(e)