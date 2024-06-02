variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "exampledb"
}

variable "db_user" {
  description = "The database username"
  type        = string
  default     = "foo"
}

variable "db_password" {
  description = "The database password"
  type        = string
  default     = "bar12345"
}
