# This doc is for talking all about Terraform.
**Authors: Sony K Sunny, Manoj Madhusoodhanan**
## terraform init
The command is used to initialize a working directory containing Terraform configuration files.

Refer this [link](https://www.terraform.io/cli/commands/init)
#### Questionaire:
1. How to skip input(yes/no) while run _terraform init_ at CI/CD pipeline?

    - Ans: terraform init -force-copy

2. How to perform _terraform init_ when you are using same configuration on same executor(static and ran for a different AWS account) for a new AWS account?

    - Ans: terraform init -reconfigure

    - Refer this [link](https://www.terraform.io/cli/commands/init#backend-initialization)

3. Do _terraform init_ validate configurations?

    - Ans: Yes. _terraform init_ does validate and configure the configuration’s backend if present.

## terraform validate
It is using to validate syntatically configuration files already initialized. So please ensure _terraform init_ has executed before _terraform validate_. _terraform validate_ do not validate backend configuration.

Refer this [link](https://www.terraform.io/cli/commands/validate)

#### Questionaire:
1. What is difference between _terraform validate_ & _terraform init_ on validation process?
    - _terraform init_ will validate both configuration and backend.
    - _terraform validate_ will validate configuration files only if already exists.
## terraform plan

## terraform apply

## terraform destroy
