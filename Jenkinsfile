pipeline{  
    agent any 
    tools {
        maven "maven3.8.6"
    }
    environment{ 
        DOCKERHUB_CREDENTIALS = credentials("DOCKERHUB_CRED") 
    } 
   stages {
       stage ("1. Git Clone") {
           steps {
               git branch: 'main', url: 'https://github.com/iambowcreek/edu_abc_tech.git'
           }
       }
       stage('2. Compile SRC'){  
           steps{  
               sh "mvn compile"  
           }  
       }
       stage('3. Test SRC'){  
           steps{  
               sh "mvn test"  
           }  
       }  
       stage('4. Build Package'){  
           steps{  
               sh "mvn clean package"  
           }  
       }  
        stage('5. Docker Build Package'){ 
            steps{
                sh "docker build -t iambowcreek/edu_abc_tech ." 
            } 
        } 
        stage("6. Push To Dockerhub"){ 
            steps{ 
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push iambowcreek/edu_abc_tech:latest" 
            } 
        }
        stage("7. Execute Ansible"){ 
            steps{
                credentialsId: 'Ansible_ec2-user',
                playbook: '/home/ansible/play.yml',
                //inventory: '/path/to/inventory.ini'
                sh '''
                pwd

                ansible-playbook play.yml
                 //ansiblePlaybook credentialsId: 'Ansible_ec2-user', disableHostKeyChecking: true, installation: 'ansible', inventory: 'dev.inv', playbook: 'ansible.yml'
                 '''
            } 
        }
   }
}
