resource "aws_autoscaling_group" "nginx_asg" {
  desired_capacity     = 2
  max_size             = 6
  min_size             = 2
  vpc_zone_identifier  = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
    aws_subnet.private_subnet_3.id
    ]
  launch_template {
    id      = aws_launch_template.lt_nginx.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.nginx_tg.arn]

  tag {
    key                 = "Name"
    value               = "nginx-asg"
    propagate_at_launch = true
  }
}
