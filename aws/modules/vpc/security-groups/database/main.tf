resource "aws_security_group" "database" {
  name        = "${var.name}"
  description = "Allow Postgres connection to instances under specific security groups"
  vpc_id      = "${var.vpc_id}"

  ingress {
      protocol        = "tcp"
      security_groups = ["${split(",", var.security_groups)}"]
      from_port       = 5432
      to_port         = 5432
  }

  tags {
      Name      = "${var.name}"
      Terraform = "true"
  }
}
