# tests/validate.tftest.hcl
# Uses mock providers — no AWS credentials needed. Safe to run in CI validate job.

mock_provider "aws" {}

variables {
  environment   = "dev"
  ami_id        = "ami-0c456f2cfcc96df82"
  instance_type = "t3.micro"
}

run "valid_environment" {
  command = plan

  assert {
    condition     = var.environment == "dev"
    error_message = "Environment should be dev in this test run."
  }
}

run "invalid_environment_rejected" {
  command = plan

  variables {
    environment = "production"
  }

  expect_failures = [var.environment]
}

run "instance_type_in_sentinel_allowed_list" {
  command = plan

  assert {
    condition     = contains(["t3.micro", "t3.small", "t3.medium", "t3.large"], var.instance_type)
    error_message = "instance_type must be in the Sentinel-approved list."
  }
}
