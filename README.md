# Terraform Autoscaling

This project provisions a **scalable, highly available Nginx web application** on **AWS** using **Terraform** and monitors the web application with CloudWatch.

## Features
- VPC with 3 public and 3 private subnets
- Application Load Balancer distributing traffic to private EC2s
- Auto Scaling Group with dynamic scaling via CloudWatch alarms
- 100% automated provisioning using Infrastructure as Code (IaC)


## How to Run

terraform init
terraform plan
terraform apply
