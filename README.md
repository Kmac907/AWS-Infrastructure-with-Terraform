# AWS Infrastructure with Terraform

This project sets up a simple AWS infrastructure using Terraform. The infrastructure includes a VPC, public and private subnets, an EC2 instance running a Flask application, and a PostgreSQL RDS instance. The Flask application allows users to submit data, which is then stored in the RDS database.

## Architecture Overview

![Architecture Diagram](https://github.com/Kmac907/AWS-Infrastructure-with-Terraform/assets/120307903/267dc37e-5b75-404d-b59c-853277e3c035)

### Components

- **VPC (10.0.0.0/16):** The Virtual Private Cloud that contains all the other resources.
- **Public Subnet (10.0.1.0/24):** The subnet where the EC2 instance resides, allowing it to be accessible from the internet.
- **Private Subnet (10.0.2.0/24):** The subnet where the RDS instance resides, making it accessible only within the VPC.
- **Internet Gateway (IGW):** Enables internet access for resources in the public subnet.
- **NAT Gateway:** Allows resources in the private subnet to access the internet while remaining private.
- **EC2 Instance:** Runs a Flask application that interacts with the RDS instance.
- **RDS Instance:** PostgreSQL database that stores user data submitted via the Flask application.
- **CloudWatch Alarms:** Monitors the CPU utilization of both the EC2 and RDS instances.
- **SNS Topic:** Sends notifications when CloudWatch alarms are triggered.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and configured with your AWS credentials.
- A valid AWS account with permissions to create and manage the necessary resources.

## Getting Started

### Cloning the Repository

```sh
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
```

### Initialize Terraform

Initialize the Terraform working directory:

```sh
terraform init
```

### Apply the Configuration

Create an execution plan and apply the configuration to deploy the infrastructure:

```sh
terraform plan
terraform apply
```

Type `yes` when prompted to confirm the application.

### Destroy the Infrastructure

When you no longer need the infrastructure, you can destroy it using:

```sh
terraform destroy
```

Type `yes` when prompted to confirm the destruction.

## Application Details

The EC2 instance runs a Flask application that provides an endpoint (`/submit`) to accept POST requests with user data. The data is stored in the PostgreSQL RDS instance.

### Example Request

To submit data to the Flask application:

```sh
curl -X POST -H "Content-Type: application/json" -d '{"name": "John Doe"}' http://<ec2-instance-public-ip>/submit
```

## Monitoring

CloudWatch alarms are set up to monitor the CPU utilization of both the EC2 and RDS instances. Notifications are sent to an SNS topic, which can be configured to send alerts via email.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request for any improvements.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
