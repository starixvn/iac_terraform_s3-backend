##Init
terraform init -input=false --backend-config=variable.d/at/prod/backend.conf
terraform plan -lock=false -var-file="variable.d/at/prod/variables.tfvars