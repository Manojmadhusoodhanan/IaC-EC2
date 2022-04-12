#module "key_pair" {
#  source = "terraform-aws-modules/key-pair/aws"
#  key_name   = "sony_aws"
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC09gd3vaRpc9B78huJoX5w3SrNgEG9WQYdgY1Qlk+7QUoc3RtggCQLeXt4RVET9mwF7TvWCD0XP1DBXT8v1Jaj9T4Ktd9Ez4QOvqHH4ZfFT7iheEZo6ewZjyh3IHwYpl/jQ3lLN53ENVNvCjbz/gpjN18vtxGEwBiWZFpm63joMQq5YBLdSWQpCQilnNqrzpXXPeX4Bh7GYPoLNIgWqNogH4caZKLVvquqxoVpx8VLpd/1wMfWOB+paM7eGA19KEfn7t6ms/Zm2jqjEsJFnDSIbaVJXiI3iSNDMFtFKfCCaY4aqssf94xLKF/ISTxbX43zzaZ9OOgIpc0BZs4HJ26DMv1hfGncCQ53tmahc1kRH9pxQgANjrEuDODmA8iPGj4rKMQ5UwB2Hb01SMs6JHpVEXn+1kYYuH0eQf3IHpv4Lgzj1jMmn1CAP+mQcdNpD8gN+rDFeefh1rcyfn7jOjrs3dpbpgk1ItMiHM/4B53OxqwYGPCwdD1WkJlAuWd+b0k= root@jenkins"
#}

module "ec2" {
  source       = "./ec2"
}
  
module "vpc" {
  source       = "./vpc"
}
