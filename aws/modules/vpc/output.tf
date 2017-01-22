output "vpc-id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc-cidr-block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

# Subnet IDs

output "public-subnet-az1-id" {
  value = "${aws_subnet.public-subnet-az1.id}"
}

output "public-subnet-az2-id" {
  value = "${aws_subnet.public-subnet-az2.id}"
}

output "backend-subnet-az1-id" {
  value = "${aws_subnet.backend-subnet-az1.id}"
}

output "backend-subnet-az2-id" {
  value = "${aws_subnet.backend-subnet-az2.id}"
}

output "db-subnet-az1-id" {
  value = "${aws_subnet.db-subnet-az1.id}"
}

output "db-subnet-az2-id" {
  value = "${aws_subnet.db-subnet-az2.id}"
}

# Security groups IDs
output "sg_web_application_id" {
  value = "${module.web-application.id}"
}

output "sg_cache_id" {
  value = "${module.cache.id}"
}

output "sg_database_id" {
  value = "${module.database.id}"
}
