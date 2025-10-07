resource "aws_launch_template" "lt_nginx" {
  name_prefix   = "lt-nginx"
  image_id      = "ami-0254b2d5c4c472488"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  key_name               = "my-key"

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl enable nginx
              systemctl start nginx
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = { Name = "lt-nginx" }
  }
}
