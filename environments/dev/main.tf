module "vpc" {
  source             = "../../aws/modules/vpc"
  env                = "${var.env}"
  availability_zone1 = "${var.availability_zone1}"
  availability_zone2 = "${var.availability_zone2}"
}
