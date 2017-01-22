resource "aws_security_group" "cache" {
  name        = "${var.name}"
  description = "Allow Redis connection to instances under specific security groups"
  vpc_id      = "${var.vpc_id}"

  ingress {
      protocol        = "tcp"
      security_groups = ["${split(",", var.security_groups)}"]
      from_port       = 6379
      to_port         = 6379
  }

  tags {
      Name      = "${var.name}"
      Terraform = "true"
  }
}
