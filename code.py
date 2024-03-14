import boto3
import csv
import io

def lambda_handler(event, context):
    # Bucket and object key
    bucket_name = 'jenkins-bucket-with-terraform'
    object_key = 'month.csv'

    # DynamoDB table details
    dynamodb_table_name = 'MyTable'
    dynamodb_key = 'id'

    # Create an S3 client
    s3 = boto3.client('s3')

    # Create a DynamoDB client
    dynamodb = boto3.client('dynamodb')

    try:
        # Get the object from S3
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        # Read the CSV content from the S3 object
        csv_content = response['Body'].read().decode("utf-8")

        # Parse the CSV content
        csv_reader = csv.reader(io.StringIO(csv_content))

        # Process each row in the CSV
        for row in csv_reader:
            try:
                # Assuming the first column in the CSV is the ID
                item_id = row[0]

                # Ensure the 'id' attribute is correctly formatted as String
                dynamodb_item = {dynamodb_key: {'S': str(item_id)}}

                # Insert item into DynamoDB table
                dynamodb.put_item(
                    TableName=dynamodb_table_name,
                    Item=dynamodb_item
                )

                # Do something with each row (you can modify this part based on your requirements)
                print(row)
            except (ValueError, IndexError) as row_error:
                print(f"Skipping row {row}: {row_error}")

        # Add a log statement to confirm when the process is completed
        print("CSV data processed and inserted into DynamoDB successfully.")

        return {
            'statusCode': 200,
            'body': 'CSV data read and inserted into DynamoDB successfully.'
        }

    except Exception as e:
        print(f"Error processing CSV and inserting into DynamoDB: {e}")
        return {
            'statusCode': 500,
            'body': f'Error processing CSV and inserting into DynamoDB: {e}'
        }

