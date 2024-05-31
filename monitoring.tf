resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "cpu_utilization_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    InstanceId = aws_instance.web.id
  }
  alarm_description = "This metric monitors EC2 CPU utilization"
  alarm_actions     = [aws_sns_topic.alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization_alarm" {
  alarm_name          = "rds_cpu_utilization_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.example.id
  }
  alarm_description = "This metric monitors RDS CPU utilization"
  alarm_actions     = [aws_sns_topic.alarms.arn]
}

resource "aws_sns_topic" "alarms" {
  name = "alarms_topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = "youremail@example.com" # Change to your email address
}
