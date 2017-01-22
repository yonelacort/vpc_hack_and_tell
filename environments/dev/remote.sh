if [ $# -eq 0 ]
  then
    echo "You must provide the profile"
    exit
fi

terraform remote config \
    -backend=s3 \
    -backend-config="bucket=vpc-hack-and-tell" \
    -backend-config="key=hack-and-tell/dev/terraform.tfstate" \
    -backend-config="region=eu-central-1" \
    -backend-config="profile=$1"
