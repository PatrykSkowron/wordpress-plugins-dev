# WORDPRESS PLUGINS DEVELOPMENT PLAYGROUND

This project goal is to help to develop and test wordpress plugins locally

# DEPENDENCIES

* docker
* docker-compose

# RUNNING

To run wordpress on local machine using docker-compose first need to set up password to DB.

```bash
export PASSWORD=<password>
```

Then need to run containers repsonsible for wordpress instance as well as MariaDB instance linked to it

```bash
make run
```

# DEPLOYING TO EC2 (AWS)

If you want to run wordpress remotely for demo purposes, you can deploy it to EC2 instance (set to t2.micro that is in free tier).
In order to do this, first you need to create aws account in order to get aws credentials: [instruction](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html)
Also, need to install Terraform in version 0.12.17+ [install terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)

Also, you may want to set your rsa public key and your public IP as allowed to connect by SSH:
```bash
export my_ip=<public_ip>
export ssh_rsa_pub=<rsa public>
```
If not, Makefile will set them for you (works on linux/ubuntu 18.04)

Then you are ready for deploy!

```bash
make deploy
```

after deploy, you can run your wordpress remotely with command:
```bash
make run_remote
``` 
 
 Congratulations, you've deployed your wordpress site!
 
# PLUGINS

plugins/ directory contains three simple plugins:

## first

Adding footer text (constant)

## with_options

Add footer text based on options.

## dynamic_forms

Add drop-down list with custom options that are set in options page.

### TODO DevOps
 
- deployment with TF check proper version / install

### TODO

- add multiple drop-down lists (new drop down for every line in options)
- add saving selections to DB (admin-post.php) [link](https://premium.wpmudev.org/blog/handling-form-submissions/)
- add showing simple statistics about user choices