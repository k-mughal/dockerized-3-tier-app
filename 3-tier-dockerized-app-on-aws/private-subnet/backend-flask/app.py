import os
import psycopg2
from dotenv import load_dotenv
from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

load_dotenv()
CORS(app)  # Enable CORS for all routes

# QLAlchemy database URI
SQLALCHEMY_DATABASE_URI = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"


app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI

db = SQLAlchemy(app)

class Users(db.Model):
    __tablename__ = 'Users_Table'  
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(200), nullable=True)
    email = db.Column(db.String(200), nullable=True)
    password = db.Column(db.String(20), nullable=True)

with app.app_context():
    db.create_all()

@app.route('/customers-list', methods=['GET'])
def get_customers():
    customers = Users.query.all()
    cust_list = [
        {'username': cust.username, 'email': cust.email, 'password': cust.password} for cust in customers
    ]
    return jsonify({'Customers': cust_list})

@app.route('/create-customer', methods=['POST'])
def create_customer():
    data = request.get_json()
    new_customer = Users(username=data['username'], email=data['email'], password=data['password'])
    db.session.add(new_customer)
    db.session.commit()
    return jsonify({'message': 'User Created'}), 201


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)



############## THIS CODE USES ACCESS KEY & SECRET MANAGER CREDENTIALS TO CONNECT WITH DATABASE#####
'''
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

@app.route('/getPersons')  # Modified route name for clarity
def getPersons():
    response = callDbWithStatement("SELECT * FROM users")
    records = response['records']

    persons = []

    for record in records:
        person = {
            'username': record[1]['stringValue'],
            'email': record[2]['stringValue'],
            'password': record[3]['stringValue']
        }
        persons.append(person)

    print(persons)
    return jsonify(persons)



@app.route('/createPerson', methods=['POST'])  # API 2 - createPerson
def createPerson():
    request_data = request.get_json()
    #personId = str(request_data['personId'])
    username = request_data['username']
    email = request_data['email']
    password = request_data['password']
    callDbWithStatement("INSERT INTO users(username, email, password) VALUES ('"
                        + username + "', '" + email + "', '" + password + "');")
    return jsonify({'status': 'ok'})

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
'''