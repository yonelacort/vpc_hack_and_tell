resource "aws_security_group" "web-application" {
  name        = "${var.name}"
  description = "Web applications security group"
  vpc_id      = "${var.vpc_id}"

  ingress {
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 80
      to_port     = 80
  }

  ingress {
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 443
      to_port     = 443
  }

  ingress {
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 22
      to_port     = 22
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
      Name      = "${var.name}"
      Terraform = "true"
  }
}
