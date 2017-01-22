# Internet VPC
resource "aws_vpc" "vpc" {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    # Enable custom domain mapping
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags {
        Name = "vpc-${var.env}"
        Terraform = "true"
    }
}


# Internet GW
resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name      = "gw-${var.env}"
        Terraform = "true"
    }
}
