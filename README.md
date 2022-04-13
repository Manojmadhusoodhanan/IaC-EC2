# This doc is for talking all about Terraform.
**Authors: Sony K Sunny, Manoj Madhusoodhanan**
## terraform init
Refere this [link](https://www.terraform.io/cli/commands/init)
#### Additional use cases
1. How to skip input(yes/no) while run _terraform init_ at CI/CD pipeline?

Ans: terraform init -force-copy

2. How to perform _terraform init_ when you are using same configuration on same executor(static and ran for a different AWS account) for a new AWS account?

Ans: terraform init -reconfigure

Refer this [link](https://www.terraform.io/cli/commands/init#backend-initialization)

3. Do _terraform init_ validate configurations?

Ans: Yes. _terraform init_ does validate and configure the configuration’s backend if present.

## terraform validate

## terraform plan

## terraform apply

## terraform destroy
