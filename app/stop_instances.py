import boto3
import datetime
import pytz

region = 'eu-central-1'
aws_access_key_id = 'YOUR_ACCESS_KEY_ID'
aws_secret_access_key = 'YOUR_SECRET_ACCESS_KEY'

timezone = 'Europe/Brussels'
working_hours_start = datetime.time(8, 0, 0)
working_hours_end = datetime.time(18, 0, 0)

# Create a Boto3 EC2 client
ec2 = boto3.client('ec2', region_name=region, aws_access_key_id=aws_access_key_id, aws_secret_access_key=aws_secret_access_key)

# Get the current time in the specified time zone
tz = pytz.timezone(timezone)
now = datetime.datetime.now(tz)

# Check if the current time is within working hours
if now.time() >= working_hours_start and now.time() <= working_hours_end:
    print('Current time is within working hours. No instances will be stopped.')
else:
    # Get a list of all running instances
    instances = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])['Reservations']

    # Stop each instance
    for reservation in instances:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            print('Stopping instance:', instance_id)
            ec2.stop_instances(InstanceIds=[instance_id])
