cd spokes/$2

export ARM_CLIENT_ID=$(az keyvault secret show --vault-name "$1" --name "client-id"  --query value -o tsv)
export ARM_CLIENT_SECRET=$(az keyvault secret show --vault-name "$1" --name "client-secret"  --query value -o tsv)
export ARM_TENANT_ID=$(az keyvault secret show --vault-name "$1" --name "tenant-id"  --query value -o tsv)
export ARM_ACCESS_KEY=$(az keyvault secret show --vault-name "$1" --name "access-key"  --query value -o tsv)

terraform init

echo "Execute Terraform plan"
terraform plan -out=tfplan -input=false

echo "Execute Terraform apply"
terraform apply "tfplan"