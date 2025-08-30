# CI/CD Pipeline for Python-Flask App on AWS

This project outlines the process of deploying a Python Flask application using a CI/CD (Continuous Integration/Continuous Delivery) pipeline on the Amazon Web Services (AWS) cloud The pipeline is designed to automate the build and deployment process whenever a developer pushes code to a Git repository.

The project leverages the following tools to create a robust DevOps CI/CD pipeline:

* **Git**: Used for version control and to trigger the pipeline.
* **Jenkins**: The central automation server for continuous integration and continuous delivery.
* **Ansible**: Utilized for deployment tasks.
* **Docker**: Used to containerize the application and create a Docker image.
***Kubernetes**: The container orchestration platform for deploying the application.


<img width="1814" height="660" alt="docker" src="https://github.com/user-attachments/assets/4e7be75f-845b-4711-8960-051e744159cd" />

---

## 1. AWS Infrastructure Setup

The initial step involves setting up the AWS infrastructure using **Terraform**. This will provision the necessary resources to host our services.

The following AWS components will be created:

* **VPC** (Virtual Private Cloud)
* **Internet Gateway**
* **Route Table**
* **Security Group**
* **EC2 Instances** for Jenkins, Docker & Ansible, and Kubernetes (Minikube)


<img width="2816" height="1536" alt="Gemini_Generated_Image_m2kc43m2kc43m2kc" src="https://github.com/user-attachments/assets/2fcbcfcf-e9c3-44b5-ae4e-9e9592e395ce" />


---

## 2. Jenkins Server Setup

After provisioning the EC2 instance, you need to set up Jenkins.

#### Install Jenkins
Run the following commands to install Jenkins:

```bash
sudo dnf update -y
sudo dnf install java-17-amazon-corretto -y
sudo wget -O /etc/yum.repos.d/jenkins.repo [https://pkg.jenkins.io/redhat-stable/jenkins.repo](https://pkg.jenkins.io/redhat-stable/jenkins.repo)
sudo rpm --import [https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key](https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key)
sudo dnf install jenkins -y 
sudo systemctl enable jenkins 
sudo systemctl start jenkins
'''bash
First-Time Login
```bash
To get the initial admin password for Jenkins, use this command:
