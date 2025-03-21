# Azure Terraform Example
__Using Terraform v1.1.6+__

Create virtual network, network security group, and two virtual machines using a module definition.
Based on GCP infrastructure migrated to Azure.

## VM 1 - Docker ready
Used for deployment Jenkins on Docker

## VM 2 - Docker ready, Docker compose, JDK 17 and NodeJS LTS
Used for web apps deployment 

## Setup and Configuration

1. Create a `terraform.tfvars` file based on the template:
   ```
   cp terraform.tfvars.example terraform.tfvars
   ```
2. Get your Azure credentials with:

   ```bash
   az login
   az account set --subscription="YOUR_SUBSCRIPTION_ID"
   az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_ID"
   ```

3. Edit the `terraform.tfvars` file to add your Azure credentials:
   ```
   azure_subscription_id = "your-subscription-id"
   azure_tenant_id       = "your-tenant-id"
   azure_client_id       = "your-client-id"
   azure_client_secret   = "your-client-secret"
   ```

4. Ensure you have a valid SSH key at `~/.ssh/id_rsa.pub`
   If not, generate a new one with:
   ```
   ssh-keygen -t rsa -b 4096
   ```

5. Run Terraform commands directly:
   ```
   terraform init
   terraform plan
   terraform apply
   ```

## Resulting infrastructure on Azure

The command `terraform apply` will create:

- 1 Resource Group
- 1 Virtual Network with subnet
- 1 Network Security Group with rules for SSH (port 22), HTTP (port 80), and Jenkins (port 8080)
- 2 Virtual machine instances with Ubuntu 22.04 LTS
- 2 Dynamic Public IP addresses, with a DNS assigned.

## Troubleshooting

- If you encounter errors during `terraform apply`, carefully read the error messages for troubleshooting.
- If the SSH key is not found, ensure you have a valid SSH key at `~/.ssh/id_rsa.pub`.
- If a deployment hangs or fails, check the Azure portal to see which resources were created and clean them up manually if needed.

## More templates

https://registry.terraform.io/browse/modules?provider=azure&verified=true

