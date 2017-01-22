# Hack & Tell - VPC with Terraform in AWS

This repository is meant to instruct on how to create a custom VPC in AWS with subnets across multiple availability zones.

# Dependencies

## Installing terraform

You can install terraform through brew

```bash
$ brew install terraform
```

or downloading it [here](https://www.terraform.io/downloads.html)

# Initializing an environment

Example on how to initialize `dev` environment in `eu-central-1` region:

```bash
$ cd environments/dev
$ chmod u+x init.sh
$ ./remote.sh <profile>
```
The script set the remote config in the desired S3 bucket:

```bash
$ terraform remote config \
    -backend=s3 \
    -backend-config="bucket=<bucket-name>" \
    -backend-config="key=<bucket-region>-<environment>/terraform.tfstate" \
    -backend-config="region=<bucket-region>"
    -backend-config="profile=$1"
```

Note: You can configure your profile via:
- the AWS CLI (here)[http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html],
- or manually, edit the file `~/.aws/credentials`

```
[<profile-name>]
[default]
aws_access_key_id = <your-access-key>
aws_secret_access_key = <your-secrete-key>
```

And then, to fetch the modules:
```bash
$ terraform get
```

It'll be required to have a `terraform.tfvars` with all variables set in `terraform.tfvars.example`.
Eventually we can look at solutions on how remotely store these secrets in the cloud, like [Vault](https://www.hashicorp.com/blog/vault.html)

# Terraform commands

Whenever a new module is added in an environment, it'll be required to run `terraform get`.

* `terraform plan` will show the planned changes in the infrastructure, showing the artifacts that will be destroyed, changed or added.
* `terraform apply` will apply the planned changes in the infrastructure. It's always recommended to run `terraform plan` to ensure the changes you expect are reflected in the plan.
* `terraform destroy` will destroy all the infrastructure created for an environment.

There are more commands that can be looked up [here](https://www.terraform.io/docs/commands/index.html)

# Work done from the AWS web console

- Creation of domain public hosted zone.
- Creation of IAM user with admin role used by terraform.
- Request SSL certificates for a domain/subdomains has to be done through the web console. In this process the root account will receive confirmation emails.

# Modules

## `./aws/modules/vpc`

### Subnets

It defines a custom VPC with the following subnets:
- 2 public for internet facing APIs and NAT Gateways
  - `public-subnet-az1-<env>`
  - `public-subnet-az2-<env>`
- 2 private for internal backend services
  - `backend-subnet-az1-<env>`
  - `backend-subnet-az2-<env>`
- 2 private for databases and caches
  - `db-subnet-az1-<env>`
  - `db-subnet-az2-<env>`

There's one subnet of each type in a different availability zone to have a highly available and resilient infrastructure, so if there's an availability zone that goes down, the system will be still functioning.

#### Public subnets configuration

The route table of the public subnets needs to have the Internet Gateway associated to it, since instances hosted in these subnets need to allow inbound/outbound connections to/from the VPC.


#### Private subnets configuration

Whilst the route table of the private subnets needs to have the NAT Gateway associated to it to allow outbound connections from the VPC.

In order to let the instances within the private subnets to have outbound connections to the internet (for software updates), it'll be required to create a NAT Gateway in a public subnet per availability zone, so if one AZ goes down, the other one will keep working.
At the same time, an elastic ip address need to be assigned per NAT Gateway to be able to allow these outbound connections.

*Note: It's recommended to use NAT Gateways, in detriment of NAT instances, because AWS takes care of updating software and scalability.*

### Network ACLs

An ACL adds a layer of security acting as firewall to control inbound and outbound traffic operating at the subnet level.
Unlike ACLs, security groups provide a security layer at the instance level.

Here you can find all differences between ACLs and security groups:
http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Security.html#VPC_Security_Comparison

It's recommended to set the numbers of the rules in increments of 100 to leave space in case there's a need of adding rules in between the ones already set.

#### Public subnets Network ACL

There's one Network ACL created for the all public subnets, allowing ingress/egress rules for TCP protocol in ports for all IP addresses:
- 22 (SSH)
- 80 (HTTP)
- 443 (HTTPS)
- 1024-65535 (Ephemeral ports)[http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_ACLs.html#VPC_ACLs_Ephemeral_Ports]

#### Private subnets Network ACL

There's one Network ACL created for all private subnets, allowing ingress/egress rules for TCP protocol in ports for all range of private IP addresses inside the VPC:
- 22 (SSH)
- 80 (HTTP)
- 443 (HTTPS)
- 1024-65535 (Ephemeral ports)[http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_ACLs.html#VPC_ACLs_Ephemeral_Ports]

# Helper documentation

Here you can find useful documentation that has been used in this terraform project

## Terraform for AWS

https://www.terraform.io/docs/providers/aws/
