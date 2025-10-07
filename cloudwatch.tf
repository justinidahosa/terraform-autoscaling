
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out"
  autoscaling_group_name  = aws_autoscaling_group.nginx_asg.name
  adjustment_type         = "ChangeInCapacity"
  scaling_adjustment      = 1
}

# Scale In Policy
resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in"
  autoscaling_group_name  = aws_autoscaling_group.nginx_asg.name
  adjustment_type         = "ChangeInCapacity"
  scaling_adjustment      = -1
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_70" {
  alarm_name          = "high-cpu-70"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_actions       = [aws_autoscaling_policy.scale_out.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.nginx_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_40" {
  alarm_name          = "low-cpu-40"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 40
  alarm_actions       = [aws_autoscaling_policy.scale_in.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.nginx_asg.name
  }
}
