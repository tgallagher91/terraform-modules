import boto3
import json
import os
from botocore.exceptions import ClientError

REGION=os.environ.get('AWS_DEFAULT_REGION')
INSTANCE_ALIAS=os.environ.get('INSTANCE_ALIAS')

connect = boto3.client('connect')

response = connect.create_instance(
    IdentityManagementType='CONNECT_MANAGED',
    InstanceAlias=INSTANCE_ALIAS,
    InboundCallsEnabled=True,
    OutboundCallsEnabled=True
)
print(json.dumps(response['Id']))