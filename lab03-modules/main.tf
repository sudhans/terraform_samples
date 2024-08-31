resource "random_string" "password_token" {
    length = 16
}

module "s3-bucket_example_complete" {
    source = "terraform-aws-modules/s3-bucket/aws//examples/complete"
    version = "2.10.0"
}