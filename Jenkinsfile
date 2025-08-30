pipeline {
    agent any
    stages {
        stage('Checkout Source Code') {
            steps {
                git url: 'https://github.com/peterezzatedward-dev/python-project', 
                    branch: 'main'
            }
        }
        
        stage('copy files') {
            steps {
                script {
                    sshagent(['asnible_server']) {
                     sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.1.229'
                     sh 'scp -r /var/lib/jenkins/workspace/python-project/* ec2-user@10.0.1.229:/home/ec2-user/python-project/'
                   }
                }
            }
        }
	stage('Docker Login , build and push to dcoker Hub') {
            steps {
				script {
				    sshagent(['asnible_server']) {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred',
                                                 usernameVariable: 'DOCKER_USER',
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
					    ssh -o StrictHostKeyChecking=no ec2-user@10.0.1.229 "
                            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin &&
                            cd /home/ec2-user/python-project/
                            ansible-playbook -i inventory.ini create-docker.yml
							"
                    '''
                }
			   }
		      }
            }
        }
        stage('Run kubernetes container and services') {
            steps {
                script {
                    sshagent(['asnible_server']) {
                     sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.1.229'
                     sh 'ansible-playbook -i /home/ec2-user/python-project/k8s.ini  /home/ec2-user/python-project/k8s.yml'
                   }
                }
            }
        }
    }
}
