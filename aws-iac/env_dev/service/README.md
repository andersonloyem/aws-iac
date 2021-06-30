1. 00_variables.tf : instancier les variables, définir leur type et donner une description
2. terraform.common.auto.tfvars varibles pre-definir (constance) ex: region aws
3. terraform.<ENV>.tfvars variables d'environnement staging vs prod
` terraform plan --var-file terraform.staging.tf `
4. secrets.tfvars variables secret à ne pas versionner (mettre sur git)
5. 01_providers.tf
6. 10_main.tf
7. 20_<OTHER>.tf (lambda)
8. README.md