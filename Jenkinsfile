pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'tfenv', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'destroy', description: 'Destroy your infrastructure?')
        booleanParam(name: 'apply', description: 'This will apply your chnages!') 

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')
        
        TF_LOG = 'DEBUG'
    }


    stages {
        stage('key') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'SSH_PRIVATE_KEY', variable: 'my-private-key')]) {
                        sh "cp \$my-private-key /var/lib/jenkins/workspace/IaC/AWS/sony_aws.pem"
                    }
                }
            }
        }
        
        stage('init') {
            steps {
                script {
                    sh "terraform  init -reconfigure"
                }
            }         
        }
        
        stage('validate') {
            steps {
                script {
                    sh "terraform validate"
                }
            }
        }
        
        stage('plan') {
            steps {
                script {
                    sh "terraform  plan -out ec2-infra.out"
                }
            }
        }
        
        stage('apply') {
            when {
                expression {
                    params.apply == true
                }
            }
            steps {
                sh 'ls -al'
                sh 'terraform  apply ec2-infra.out'
            }
        }
        
        stage('destroy') {
            when {
                expression {
                    params.destroy == true
                }
            }
            steps {
                sh 'terraform destroy --auto-approve'
            }
        }

  }
}
