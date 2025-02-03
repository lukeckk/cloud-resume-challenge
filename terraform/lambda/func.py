import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('cloudportfolio-test')

def lambda_handler(event, context):
    response = table.get_item(Key={'id': '0'})

    if 'Item' in response:
        views = int(response['Item']['views'])  
    else:
        views = 0  

    views += 1
    print(f"Updated views: {views}")

    table.put_item(Item={'id': '0', 'views': views})

    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": "*",  
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type"
        },
        "body": json.dumps({"views": views}) 
    }
