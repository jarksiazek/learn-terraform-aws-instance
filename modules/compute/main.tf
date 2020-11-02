resource "aws_instance" "web-instance" {
  count = length(var.subnet_web_ids)
  ami = "ami-00a205cb8e06c3c4e"
  instance_type = "t2.micro"
  subnet_id = var.subnet_web_ids[count.index]
  security_groups = [var.security_group_id]
  user_data = <<-EOF
                  #!/bin/bash
                  sudo su
                  yum -y install httpd
                  echo "<p> My Instance </p>" >> /var/www/html/index.html
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  EOF

  tags = {
    name = format("%s%s", "terraform-ec2_web_", count.index + 1)
    target = count.index + 1
  }
}

output "instance_ids" {
  value = aws_instance.web-instance.*.id
}