
PASSWORD ?= qwerty12345!
PLUGINS ?= plugins/first plugins/with_options plugins/dynamic_forms

.PHONNY: run
run:
	PASSWORD=${PASSWORD} docker-compose up -d

.PHONNY: stop
stop:
	docker-compose stop


.PHONNY: package
package:
	zip -r package.zip Makefile docker-compose ${PLUGINS}


tf_plan: package
	cd infra/terraform && \
	terraform plan -var-file=config.tfvars -out=tfplan

.PHONNY: deploy
deploy: tf_plan
	cd infra/terraform && \
	terraform apply -auto-approve tfplan && \
	rm tfplan

destroy:
	cd infra/terraform && \
	terraform destroy -var-file=config.tfvars

distclean:
	rm -rf html
	rm -rf database
