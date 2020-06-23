provider "aws" {
  region = "us-east-1"
}

resource "random_id" "testing_suffix" {
  byte_length = 1
}

locals {
  suffix = random_id.testing_suffix.hex
}

resource "aws_s3_bucket" "restricted" {
  bucket = "sensitive-data-${local.suffix}"
  force_destroy = true
}

resource "aws_s3_bucket" "logs" {
  bucket = "logs-${local.suffix}"
  force_destroy = true
}

locals {
  assume_role_policy_ec2 = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
  EOF
}

resource "aws_iam_role" "application" {
  name = "application"
  assume_role_policy = local.assume_role_policy_ec2
}

resource "aws_iam_role_policy_attachment" "application_S3FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role = aws_iam_role.application.name
}

resource "aws_iam_role" "firewall" {
  name = "firewall"
  assume_role_policy = local.assume_role_policy_ec2
}

resource "aws_iam_role_policy_attachment" "firewall_S3FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role = aws_iam_role.firewall.name
}

resource "aws_iam_user" "delivery" {
  name = "delivery"
}

resource "aws_iam_user_policy_attachment" "delivery_Admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  user = aws_iam_user.delivery.name
}

output "restricted_bucket_id" {
  value = aws_s3_bucket.restricted.id
}

output "logs_bucket_id" {
  value = aws_s3_bucket.logs.id
}