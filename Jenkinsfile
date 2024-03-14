pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('AWS-Credentials')  // Credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Rahilz313/Terraform-AWS-Jenkins.git'
            }
        }

        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform plan -out tfplan'
            }
        }

        stage('Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}
