# Subnets
resource "aws_subnet" "public-subnet-az1" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    cidr_block              = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "${var.availability_zone1}"

    tags {
        Name = "public-subnet-az1-${var.env}"
        Terraform = "true"
    }
}

resource "aws_subnet" "public-subnet-az2" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "${var.availability_zone2}"

    tags {
        Name = "public-subnet-az2-${var.env}"
        Terraform = "true"
    }
}

resource "aws_subnet" "backend-subnet-az1" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "${var.availability_zone1}"

    tags {
        Name = "backend-subnet-az1-${var.env}"
        Terraform = "true"
    }
}

resource "aws_subnet" "backend-subnet-az2" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    cidr_block              = "10.0.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "${var.availability_zone2}"

    tags {
        Name = "backend-subnet-az2-${var.env}"
        Terraform = "true"
    }
}

resource "aws_subnet" "db-subnet-az1" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    cidr_block              = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "${var.availability_zone1}"

    tags {
        Name = "db-subnet-az1-${var.env}"
        Terraform = "true"
    }
}

resource "aws_subnet" "db-subnet-az2" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    cidr_block              = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "${var.availability_zone2}"

    tags {
        Name = "db-subnet-az2-${var.env}"
        Terraform = "true"
    }
}
