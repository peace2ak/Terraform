
```markdown
# Output Information

- Terraform stores the returned value of all created resources in the Terraform state.
- Use the `output` block to print these attributes.
- Use `local-exec` provisioner to save information to a file.

## Output Attributes

Example output block:
```tf
output "instance_ip_addr" {
  value = aws_instance.server.public_ip
}
```

Using `local-exec` provisioner to execute a command locally:
```tf
provisioner "local-exec" {
  command = "echo aws_instance.out_inst.private_ip >> private_ips.txt"
}
```

## Exercise 4

```bash
cp -r exercise_3 exercise_4
cd exercise_4
```

Update `instance.tf` to store data locally:
```tf
# ... previous code from exercise_3

output "PublicIP" {
  value = aws_instance.dove-inst.public_ip
}

output "PrivateIP" {
  value = aws_instance.dove-inst.private_ip
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

To destroy the instance and cleanup:
```bash
terraform destroy
```
