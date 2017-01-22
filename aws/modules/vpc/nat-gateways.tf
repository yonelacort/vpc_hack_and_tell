# NAT Gateways
resource "aws_eip" "nat-az1" {
  vpc = true
}

resource "aws_eip" "nat-az2" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw-az1" {
  allocation_id = "${aws_eip.nat-az1.id}"
  subnet_id     = "${aws_subnet.public-subnet-az1.id}"
}

resource "aws_nat_gateway" "nat-gw-az2" {
  allocation_id = "${aws_eip.nat-az2.id}"
  subnet_id     = "${aws_subnet.public-subnet-az2.id}"
}
