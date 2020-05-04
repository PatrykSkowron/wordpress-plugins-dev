
PASSWORD ?= qwerty12345!
PLUGINS ?= plugins/first plugins/with_options plugins/dynamic_forms

my_ip ?= $(shell dig +short myip.opendns.com @resolver1.opendns.com.)
ssh_rsa_pub ?= $(shell cat ~/.ssh/id_rsa.pub)
ec2_ip ?= $(shell terraform output -state=infra/terraform/terraform.tfstate ec2_ip)


.PHONNY: run
run:
	PASSWORD=${PASSWORD} docker-compose up -d

.PHONNY: stop
stop:
	docker-compose stop


.PHONNY: package
package:
	zip -r package.zip Makefile docker-compose.yml ${PLUGINS}


tf_plan: package
	cd infra/terraform && \
	terraform plan -var 'allowed_ips=["${my_ip}/32"]' -var "deployer_public_key=${ssh_rsa_pub}" -out=tfplan

check:
	echo ${my_ip}
	echo ${ssh_rsa_pub}

.PHONNY: deploy
deploy: tf_plan
	cd infra/terraform && \
	terraform apply -auto-approve tfplan && \
	rm -f tfplan

run_remote: package
	scp package.zip ubuntu@${ec2_ip}:/home/ubuntu/package.zip
	scp run_remote.sh ubuntu@${ec2_ip}:/home/ubuntu/run_remote.sh
	ssh -t ubuntu@${ec2_ip} '/home/ubuntu/run_remote.sh /home/ubuntu/package.zip'

destroy:
	cd infra/terraform && \
	terraform destroy -var-file=config.tfvars

distclean:
	rm -rf html
	rm -rf database
