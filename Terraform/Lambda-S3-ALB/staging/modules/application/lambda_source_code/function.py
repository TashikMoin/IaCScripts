from os import environ
import boto3
import json



def get_s3_object_keys(bucket, region, pagesize=50, maxitems=30, startingtoken=None):
    s3 = boto3.client('s3', region_name=region)
    paginator = s3.get_paginator("list_objects_v2")
    pages = paginator.paginate(Bucket=bucket, PaginationConfig={'PageSize': pagesize, 'MaxItems': maxitems, 'StartingToken': startingtoken}) 
    # we can also apply filters, suffix
    # startingtoken is set to 'None' because we are calling this function only once.
    for page in pages:
        try:
            contents = page["Contents"]
        except KeyError:
            print("ERROR!")
            break
        for obj in contents:
            yield obj["Key"] 


def get_s3_objects(bucket, region, keys):
    s3 = boto3.client('s3', region_name=region)
    for key in keys:
        obj = s3.get_object(Bucket=bucket, Key=key)
        yield json.loads(obj['Body'].read())

        
def handler(event, context):
    # Environment variables
    bucket = environ['bucket']
    region = environ['region']
    pagesize = int(environ['pagesize'])

    s3 = boto3.resource('s3') 
    # for higher level calls using boto3.resource and for low level calls using boto3.client
    s3bucket = s3.Bucket(bucket)
    size = 0
    totalCount = 0

    for key in s3bucket.objects.all():
        totalCount += 1
        size += key.size

    keys = []
    for item in get_s3_object_keys(bucket=bucket, region=region, pagesize=pagesize, maxitems=totalCount):  # response is a generator object (doing this for memory optimization, minimize execution time)
        keys.append(item)

    data = []

    for item in get_s3_objects(bucket=bucket, region=region, keys=keys): # response is a generator object (doing this for memory optimization, minimize execution time)
        data.append(item)

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({"total_objects": totalCount, "total_size_of_all_objects": size, "data": data[0:1050]})
    }