pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'tfenv', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', description: 'Destroy your infrastructure?')
        booleanParam(name: 'plan', description: 'Run terraform plan')
        booleanParam(name: 'apply', description: 'This will apply your chnages!') 

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')
        /* TF_LOG = 'DEBUG' */
    }


    stages {

        stage('init') {
            steps {
                script {
                    sh "terraform  init"
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
            steps {
                script {
                    sh "terraform  apply ec2-infra.out"
                }
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
        
        /*stage('tf Approval') {
           when {
             expression   {
                   params.autoApprove == 'true'
               }
           }    

           steps {
               script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('apply') {
            when {
                expression {
                    params.apply == 'true'
                }
            }
            
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }
        
        stage('tf Destroy') {
            when {
                expression {
                    params.destroy == 'true'
                }
            }
        
        steps {
           sh "terraform destroy --auto-approve"
        }
    }*/

  }
}
