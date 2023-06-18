
```markdown
# Terraform State Management with Backend

To improve team collaboration and manage the Terraform state effectively, it's recommended to use a remote backend. This allows multiple team members to work on the same infrastructure.

## Exercise 5

```bash
cp -r exercise_4 exercise_5
cd exercise_5
```

Create `backend.tf` file to configure the S3 backend:

```tf
terraform {
  backend "s3" {
    bucket = "terra-state-dove"  # Name of the S3 bucket
    key    = "terraform/backend" # Name of the folder created in the S3 bucket
    region = "us-east-2"         # AWS region
  }
}
```

Initialize and apply changes:

```bash
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
yes
```

To destroy the infrastructure and cleanup:

```bash
terraform destroy
yes
```

By configuring the S3 backend, the Terraform state will be stored remotely in an S3 bucket, improving collaboration and providing a centralized location for state management.
