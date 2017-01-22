module "web-application" {
  source = "./security-groups/web-application"
  vpc_id = "${aws_vpc.vpc.id}"
  name   = "web-application-${var.env}"
}

module "database" {
  source          = "./security-groups/database"
  vpc_id          = "${aws_vpc.vpc.id}"
  name            = "database-${var.env}"
  security_groups = "${module.web-application.id}"
}

module "cache" {
  source          = "./security-groups/cache"
  vpc_id          = "${aws_vpc.vpc.id}"
  name            = "cache-${var.env}"
  security_groups = "${module.web-application.id}"
}
