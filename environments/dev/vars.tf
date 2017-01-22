variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-central-1"
}
variable "availability_zone1" {
  default = "eu-central-1a"
}
variable "availability_zone2" {
  default = "eu-central-1b"
}

variable "env" {
  default = "dev"
}

variable "domain_name" {}
variable "hosted_zone_id" {}
variable "ssl_certificate_id" {}
