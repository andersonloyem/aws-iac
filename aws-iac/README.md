## Infrastructure as Code of assurly in AWS

### introduction

Ce code permet de provisioner les comptes de AWS de dev/preprod/prod automatiquement via terraform.

### structure des repertoires

service : comporte les ressources necessaires au fonctionnement de l'API notamment API gateway, route 53, SES, EC2-laod balancer, Lambda, layers, role IAM et les modules y afferant

storage : comporte les ressources necessaire au stockage de données : table et index dynamoBD, S3

security : comporte les ressources necessaire à l'implementation du protocole oauth2

Chacun de ces repertoires principales fonctionnement de façon independants et chaque repertoire est structuré comme suit :

1. 00_variables.tf : instancier les variables, définir leur type et donner une description
2. terraform.common.auto.tfvars varibles pre-definir (constance) ex: region aws
3. secrets.<ENV>.tfvars variables d'environnement staging vs prod (à ne pas versionner car secret)
` terraform plan --var-file terraform.staging.tf `
4. secrets.tfvars variables secret à ne pas versionner (mettre sur git)
5. 01_providers.tf
6. 20_<OTHER>.tf (lambda)
7. README.md
8. remote.state.tf : contient le code specifiant le repo des states (etat) de chaque environnement (à ne pas versionner car secret)

### Provisonning de la dev

0. se positionner dans un module (service/storage/security) et renseigner les fichiers :
    - remote.state.tf
```
terraform {
  backend "s3" {
    bucket     = "terraform-aws-assurly"
    key        = "<Module>.tfstate" # ex : service.tfstate
    access_key = "YOU ACCESS KEY REMOTE"
    secret_key = "YOU SECRET KEY REMOTE"
    region     = "eu-west-3"
  }
}

```
    - secrets.dev.tfvars
```
aws_access_key = "YOU ACCESS KEY"
aws_secret_key = "YOU SECRET KEY"
aws_region     = "us-east-1"
env            = "dev"
```
    - secrets.prod.tfvars (si mise en production)
```
aws_access_key = "YOU ACCESS KEY"
aws_secret_key = "YOU SECRET KEY"
aws_region     = "us-east-1"
env            = "prod"
```

1. creation du workspace de dev
```
terraform workspace new dev
terraform workspace select dev # switch to workspace dev (pas necessaire à la creation)
```
2. provisionner l'infra

```
terraform plan -var-file="secrets.dev.tfvars"
terraform apply -var-file="secrets.dev.tfvars" -auto-approve
terraform destroy -var-file="secrets.dev.tfvars" -auto-approve
```
    -auto-approve : approbation automatique

### Provisonning de la prod

Effectuer le procedure precedente en remplacant dev par prod.

### Quelques commandes :
```
terraform fmt
terraform plan -var-file="secrets.dev.tfvars"
terraform apply -var-file="secrets.dev.tfvars" -auto-approve
terraform destroy -var-file="secrets.dev.tfvars" -auto-approve
```

```
terraform workspace new prod # creation new workspace
terraform workspace new dev
terraform workspace select dev # switch to workspace dev
terraform workspace show # show actual workspace

```

```
terraform workspace new dev
terraform init -migrate-state
terraform plan -var-file="secrets.dev.tfvars"
terraform apply -var-file="secrets.dev.tfvars"
terraform show
terraform output
```
