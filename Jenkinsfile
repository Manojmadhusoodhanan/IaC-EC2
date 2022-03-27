pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'tfenv', description: 'Workspace/environment file to use for deployment')
        choiceParam(name: 'autoApprove', defaultValue: 'no', description: 'Automatically run apply after generating plan?')
        choiceParam(name: 'destroy', defaultValue: 'no', description: 'Destroy your infrastructure?')
        choiceParam(name: 'plan', defaultValue: 'yes', description: 'Run terraform plan')
        choiceParam(name: 'apply', defaultValue: 'no', description: 'This will apply your chnages!') 

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
                    params.destroy == yes || params.destroy == true
                }
            }
            steps {
                sh 'terraform destroy ec2-infra.out'
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
