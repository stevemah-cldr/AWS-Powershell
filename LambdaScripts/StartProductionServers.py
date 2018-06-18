import boto3
# Function to Start Servers
region = 'us-west-2'
# Enter your instances here: ex. ['X-XXXXXXXX', 'X-XXXXXXXX']

# ansa-dc1 = i-0e1e7575a436bda58
# epopm1 = i-0d94f48eaeacff042

instances = ['i-0e1e7575a436bda58', 'i-0d94f48eaeacff042']

def lambda_handler(event, context):
    ec2 = boto3.client('ec2', region_name=region)
    ec2.start_instances(InstanceIds=instances)
    print 'started your instances: ' + str(instances)
