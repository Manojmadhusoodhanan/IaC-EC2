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
        AWS_SSH_KEY = credentials('AWS_SSH_KEY')
        TF_LOG = 'DEBUG'
    }


    stages {
        stage('init') {
            steps {
                script {
                    sh "terraform  init -force-copy"
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
