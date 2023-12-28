from flask import Flask, request, jsonify
import os
from dotenv import load_dotenv
import boto3 
from botocore.config import Config

app = Flask(__name__)

# Load environment variables from .env file
load_dotenv()

my_config = Config(
    region_name=os.getenv('REGION')
)

rds_data = boto3.client(
    'rds-data',
    config=my_config,
    aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'),
    aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY')
)

# Database Configuration Items
aurora_db_name = os.getenv('DB_NAME')
aurora_cluster_arn = os.getenv('CLUSTER_ARN')
aurora_secret_arn = os.getenv('SECRET_ARN')

@app.route('/getPerson')  # API 1 - getPerson
def getPerson():
    #personId = request.args.get('personId')
    #response = callDbWithStatement("SELECT * FROM Persons WHERE personId='" + str(personId) + "'")
    response = callDbWithStatement("SELECT * FROM users")
    person = {}
    records = response['records']
    for record in records:
        person['username'] = record[0]['stringValue']
        person['email'] = record[1]['stringValue']
        person['password'] = record[2]['stringValue']
    print(person)
    return jsonify(person)



@app.route('/createPerson', methods=['POST'])  # API 2 - createPerson
def createPerson():
    request_data = request.get_json()
    #personId = str(request_data['personId'])
    username = request_data['username']
    email = request_data['email']
    password = request_data['password']
    callDbWithStatement("INSERT INTO Persons(username, email, password) VALUES ('"
                        + username + "', '" + email + "', '" + password + "');")
    return "ok"

def callDbWithStatement(statement):
    response = rds_data.execute_statement(
        database=aurora_db_name,
        resourceArn=aurora_cluster_arn,
        secretArn=aurora_secret_arn,
        sql=statement,
        includeResultMetadata=True
    )
    print("Making Call " + statement)
    print(response) # Delete in production
    return response

if __name__ == '__main__':
    app.run(threaded=True, host='0.0.0.0')
    
    
