output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.example.endpoint
}

output "rds_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.example.port
}
