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


# PLUGINS

plugins/ directory contains three simple plugins:

## first

Adding footer text (constant)

## with_options

Add footer text based on options.

## dynamic_forms

Add drop-down list with custom options that are set in options page.

### TODO DevOps

- auto prov. config.tfvars
- deployment with TF check proper version / install
- update README

### TODO

- add multiple drop-down lists (new drop down for every line in options)
- add saving selections to DB (admin-post.php) [link](https://premium.wpmudev.org/blog/handling-form-submissions/)
- add showing simple statistics about user choices