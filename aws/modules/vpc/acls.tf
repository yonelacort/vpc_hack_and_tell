# ACLs

resource "aws_network_acl" "public-subnet-acl" {
    vpc_id     = "${aws_vpc.vpc.id}"
    subnet_ids = ["${aws_subnet.public-subnet-az1.id}", "${aws_subnet.public-subnet-az2.id}"]

    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 80
        to_port    = 80
    }

    ingress {
        protocol   = "tcp"
        rule_no    = 200
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 443
        to_port    = 443
    }

    ingress {
        protocol   = "tcp"
        rule_no    = 300
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 22
        to_port    = 22
    }


    egress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 80
        to_port    = 80
    }

    egress {
        protocol = "tcp"
        rule_no = 200
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 443
        to_port = 443
    }

    egress {
        protocol   = "tcp"
        rule_no    = 300
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 22
        to_port    = 22
    }

    // Ephemeral ports (http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_ACLs.html)
    egress {
      protocol   = "tcp"
      rule_no    = 400
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    }

    tags {
        Terraform = "true"
        Name      = "public-acl-${var.env}"
    }
}

resource "aws_network_acl" "private-acl" {
    vpc_id     = "${aws_vpc.vpc.id}"
    subnet_ids = ["${aws_subnet.backend-subnet-az1.id}", "${aws_subnet.backend-subnet-az2.id}", "${aws_subnet.db-subnet-az1.id}", "${aws_subnet.db-subnet-az2.id}"]

    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "${aws_vpc.vpc.cidr_block}"
        from_port  = 80
        to_port    = 80
    }

    ingress {
        protocol   = "tcp"
        rule_no    = 200
        action     = "allow"
        cidr_block = "${aws_vpc.vpc.cidr_block}"
        from_port  = 443
        to_port    = 443
    }

    ingress {
        protocol   = "tcp"
        rule_no    = 300
        action     = "allow"
        cidr_block = "${aws_vpc.vpc.cidr_block}"
        from_port  = 22
        to_port    = 22
    }

    # Postgres
    ingress {
        protocol   = "tcp"
        rule_no    = 400
        action     = "allow"
        cidr_block = "${aws_vpc.vpc.cidr_block}"
        from_port  = 5432
        to_port    = 5432
    }

    # Redis
    ingress {
        protocol   = "tcp"
        rule_no    = 500
        action     = "allow"
        cidr_block = "${aws_vpc.vpc.cidr_block}"
        from_port  = 6379
        to_port    = 6379
    }

    egress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "${aws_vpc.vpc.cidr_block}"
        from_port  = 80
        to_port    = 80
    }

    egress {
        protocol   = "tcp"
        rule_no    = 200
        action     = "allow"
        cidr_block = "${aws_vpc.vpc.cidr_block}"
        from_port  = 443
        to_port    = 443
    }

    egress {
        protocol   = "tcp"
        rule_no    = 300
        action     = "allow"
        cidr_block = "${aws_vpc.vpc.cidr_block}"
        from_port  = 22
        to_port    = 22
    }

    // Ephemeral ports (http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_ACLs.html)
    egress {
      protocol   = "tcp"
      rule_no    = 400
      action     = "allow"
      cidr_block = "${aws_vpc.vpc.cidr_block}"
      from_port  = 1024
      to_port    = 65535
    }

    tags {
        Terraform = "true"
        Name      = "private-acl-${var.env}"
    }
}
