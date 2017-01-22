# route tables
resource "aws_route_table" "public-route-table" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Terraform = "true"
        Name      = "public-route-table-${var.env}"
    }
}

resource "aws_route_table" "private-route-table-az1" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat-gw-az1.id}"
    }

    tags {
      Terraform = "true"
      Name      = "private-route-table-az1-${var.env}"
    }
}

resource "aws_route_table" "private-route-table-az2" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat-gw-az2.id}"
    }

    tags {
      Terraform = "true"
      Name      = "private-route-table-az2-${var.env}"
    }
}

# route associations public
resource "aws_route_table_association" "public-az1" {
    subnet_id      = "${aws_subnet.public-subnet-az1.id}"
    route_table_id = "${aws_route_table.public-route-table.id}"
}

resource "aws_route_table_association" "public-az2" {
    subnet_id      = "${aws_subnet.public-subnet-az2.id}"
    route_table_id = "${aws_route_table.public-route-table.id}"
}

resource "aws_route_table_association" "private-backend-subnet-az1" {
    subnet_id      = "${aws_subnet.backend-subnet-az1.id}"
    route_table_id = "${aws_route_table.private-route-table-az1.id}"
}

resource "aws_route_table_association" "private-backend-subnet-az2" {
    subnet_id      = "${aws_subnet.backend-subnet-az2.id}"
    route_table_id = "${aws_route_table.private-route-table-az2.id}"
}

resource "aws_route_table_association" "private-db-subnet-az1" {
    subnet_id      = "${aws_subnet.db-subnet-az1.id}"
    route_table_id = "${aws_route_table.private-route-table-az1.id}"
}

resource "aws_route_table_association" "private-db-subnet-az2" {
    subnet_id      = "${aws_subnet.db-subnet-az2.id}"
    route_table_id = "${aws_route_table.private-route-table-az2.id}"
}
