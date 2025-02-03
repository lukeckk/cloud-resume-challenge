# Cloud Resume Challenge

This project implements a **serverless portfolio website** using AWS services. It includes a **Lambda function** connected to **DynamoDB** for tracking visitor counts and is hosted on **S3 with CloudFront** for performance and security.

---

## Architecture Overview

The architecture follows best practices for a **modern, serverless web application**:

### **Frontend**
- Static website hosted on **Amazon S3**
- Distributed globally with **AWS CloudFront** for caching and performance

### **Backend**
- **AWS Lambda function (Python)** to track visitor counts
- **Amazon DynamoDB NoSQL database** to store visitor data
- **IAM Roles & Policies** for Lambda-DynamoDB access

---

## Tech Stack

- **Frontend:** HTML, CSS, JavaScript (Hosted on S3 with CloudFront)
- **Backend:** AWS Lambda (Python) + DynamoDB
- **Infrastructure as Code:** Terraform
- **CI/CD:** GitHub Actions (Optional)
- **Monitoring:** AWS CloudWatch
