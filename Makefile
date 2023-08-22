## Build and deploy the infrastructure
## Usage: make

deploy: apply all playbook

## For development and testing purposes

BOOK2USE = prepare.yml # name of the playbook to use
PRIVATE_KEY_PATH = # path to your private key

init:
	cd terraform && terraform init

plan:
	cd terraform && terraform plan -var-file="secret.tfvars"

apply:
	cd terraform && terraform apply -var-file="secret.tfvars" --auto-approve

destroy:
	cd terraform && terraform destroy -var-file="secret.tfvars" --auto-approve

connect:
	ssh -i $(PRIVATE_KEY_PATH) ec2-user@$(shell cd terraform && terraform output instance_public_ip)

playbook:
	ansible-playbook ansible/playbook/$(BOOK2USE) -i ansible/inventory

## Populate the Ansible inventory file with the IP address of the server

OUTPUT_FILE = ansible/inventory/hosts
TEMP_FILE = temp_ip.txt

all: terraform_output update_hosts clean_temp

terraform_output:
	cd terraform && terraform output instance_public_ip > $(TEMP_FILE)

update_hosts:
	echo "[aws_server]" > $(OUTPUT_FILE)
	cat ./terraform/$(TEMP_FILE) >> $(OUTPUT_FILE)
	echo "" >> $(OUTPUT_FILE)
	echo "[aws_server:vars]" >> $(OUTPUT_FILE)
	echo "ansible_ssh_user=ec2-user" >> $(OUTPUT_FILE)
	echo "ansible_ssh_private_key_file=$(PRIVATE_KEY_PATH)" >> $(OUTPUT_FILE)

clean_temp:
	rm ./terraform/$(TEMP_FILE)
