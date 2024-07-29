# Deploy A Custom Container with Azure App Service Connected to MySQL

![alt text](https://github.com/ewoh7nix/dci-central/blob/master/dci-central-appservices-with-mysql.png)

## HOWTO

## Requirements
- Terraform
- Azure CLI
- Docker

## Provisioning Azure App Service and Azure Database for MySQL
Terraform configuration contain resources for provisioning Virtual Network and its subnet, VNET integration, NSG, Azure Database MySQL and App service.
```
$ az login
$ cd terraform/provisioning/dci_central
$ terraform init
$ terraform plan -out /tmp/dci_central.tfplan
$ terraform apply /tmp/dci_central.tfplan
```


