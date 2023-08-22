## Template to run AWS EC2 + Docker 🐋

![IMG](./readme.jpg)

### Requirements

- Terraform
- Ansible
- AWS Free Tier Account
- Unix based OS

### Steps

1. Create your ssh-key
2. Optain your variables from AWS
3. Populate the variables in `secret.tfvars` file
4. Populate the `PRIVATE_KEY_PATH` in the `Makefile`
5. Verify things like `ami`, `instance_type`, `region` in `variables.tf`
6. Run `make`
