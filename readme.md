CI/CD Pipeline for Python-Flask App on AWS
This project provides a comprehensive guide to setting up a CI/CD pipeline for a Python Flask application on AWS. The pipeline automates the entire process, from code push to a Git repository to final deployment on a Kubernetes cluster.

Key Tools Used
The pipeline is built using the following core tools:

Git: For version control and to initiate the CI/CD workflow.

Jenkins: The central automation server that orchestrates the build and delivery process.

Docker: To containerize the Flask application, ensuring it runs consistently across environments.

Ansible: Used for automating the deployment of the application.

Kubernetes (Minikube): The container orchestration platform where the final application is deployed.

1. AWS Infrastructure Setup with Terraform
The first step is to provision the necessary AWS infrastructure using Terraform. The following components are created to host the pipeline services:

VPC (Virtual Private Cloud)

Internet Gateway

Route Table

Security Group

EC2 Instances for Jenkins, Docker/Ansible, and Minikube.

2. Jenkins Server Setup
After your EC2 instance for Jenkins is provisioned, follow these steps to install and configure it.

Installation
Use the following commands to install Jenkins and its dependencies:

sudo dnf update -y
sudo dnf install java-17-amazon-corretto -y
sudo wget -O /etc/yum.repos.d/jenkins.repo [https://pkg.jenkins.io/redhat-stable/jenkins.repo](https://pkg.jenkins.io/redhat-stable/jenkins.repo)
sudo rpm --import [https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key](https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key)
sudo dnf install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

Initial Setup
To retrieve the initial administrator password for Jenkins:

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Configuration
Install Git on the Jenkins server:

sudo yum install git -y

Install the SSH plugin in Jenkins.

Generate an SSH key (ssh-keygen -t rsa -b 4096 -m PEM), copy the public key to the Docker server, and store the private key in Jenkins' global credentials.

Store your Docker Hub username and password as credentials in Jenkins.

3. Docker & Ansible Server Setup
Use these commands to set up the EC2 instance for Docker and Ansible.

Install Docker
sudo yum update -y
sudo amazon-linux-extras install docker
sudo usermod -a -G docker ec2-user
sudo service docker start
sudo systemctl enable docker

Install Ansible
sudo amazon-linux-extras enable ansible2
sudo yum install -y ansible

4. Minikube (Kubernetes) Setup
Set up a local Kubernetes environment on a dedicated EC2 instance using Minikube.

sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER && newgrp docker
curl -LO "[https://dl.k8s.io/release/$(curl](https://dl.k8s.io/release/$(curl) -L -s [https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl](https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl)"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
curl -LO [https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64](https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64)
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --driver=docker
