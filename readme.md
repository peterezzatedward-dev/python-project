# CI/CD Pipeline for Python-Flask App on AWS

[cite_start]This project outlines the process of deploying a Python Flask application using a CI/CD (Continuous Integration/Continuous Delivery) pipeline on the Amazon Web Services (AWS) cloud[cite: 1, 2]. [cite_start]The pipeline is designed to automate the build and deployment process whenever a developer pushes code to a Git repository[cite: 2].

[cite_start]The project leverages the following tools to create a robust DevOps CI/CD pipeline[cite: 3]:

* **Git**: Used for version control and to trigger the pipeline[cite: 4].
* **Jenkins**: The central automation server for continuous integration and continuous delivery[cite: 5].
* **Ansible**: Utilized for deployment tasks[cite: 6].
* **Docker**: Used to containerize the application and create a Docker image[cite: 7].
***Kubernetes**: The container orchestration platform for deploying the application[cite: 8].


<img width="1814" height="660" alt="docker" src="https://github.com/user-attachments/assets/4e7be75f-845b-4711-8960-051e744159cd" />

---

## 1. AWS Infrastructure Setup

The initial step involves setting up the AWS infrastructure using **Terraform**[cite: 9]. This will provision the necessary resources to host our services.

The following AWS components will be created:

* **VPC** (Virtual Private Cloud) [cite: 10]
* **Internet Gateway** [cite: 11]
* **Route Table** [cite: 12]
* **Security Group** [cite: 13]
* **EC2 Instances** for Jenkins, Docker & Ansible, and Kubernetes (Minikube) [cite: 14]


<img width="2816" height="1536" alt="Gemini_Generated_Image_m2kc43m2kc43m2kc" src="https://github.com/user-attachments/assets/2fcbcfcf-e9c3-44b5-ae4e-9e9592e395ce" />


---

## 2. Jenkins Server Setup

[cite_start]After provisioning the EC2 instance, you need to set up Jenkins[cite: 15].

#### Install Jenkins
[cite_start]Run the following commands to install Jenkins[cite: 16]:

```bash
sudo dnf update -y [cite: 17]
sudo dnf install java-17-amazon-corretto -y [cite: 18]
sudo wget -O /etc/yum.repos.d/jenkins.repo [https://pkg.jenkins.io/redhat-stable/jenkins.repo](https://pkg.jenkins.io/redhat-stable/jenkins.repo) [cite: 19]
sudo rpm --import [https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key](https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key) [cite: 20]
sudo dnf install jenkins -y [cite: 21]
sudo systemctl enable jenkins [cite: 22]
sudo systemctl start jenkins [cite: 23]
