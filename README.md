# Amazon EKS Cluster with Terraform

This repository contains source code to provision an EKS cluster in AWS using Terraform.

## Prerequisites
* AWS account
* AWS profile configured with CLI on local machine
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [Terraform](https://www.terraform.io/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* [Helm](https://helm.sh/docs/intro/install/)

## Remote Backend State Configuration
To configure remote backend state for your infrastructure, create an S3 bucket before running *terraform init*. In the case that you want to use local state persistence, update the *provider.tf* accordingly and don't bother with creating an S3 bucket.

### Create S3 Bucket for State Backend
```aws s3api create-bucket --bucket <bucket-name> --region <region>```

## Provision Infrastructure
Review the *varaibles.tf* and create a *terraform.tfvars* to update the default values like node size configurations (i.e. desired, maximum, and minimum). When you're ready, run the following commands:
1. `terraform init` - Initialize the project, setup the state persistence (whether local or remote) and download the API plugins.
2. `terraform plan` - Print the plan of the desired state without changing the state.
3. `terraform apply` - Print the desired state of infrastructure changes with the option to execute the plan and provision.

## Connect To Cluster
Using the same AWS account profile that provisioned the infrastructure, you can connect to your cluster by updating your local kube config with the following command:
`aws eks --region <aws-region> update-kubeconfig --name <cluster-name>`

## Deploy Application
### Helm
To deploy the application to you cluster, use helm to deploy the chart.

1. Change to the chart directory - `cd helm/charts`
2. Update the *values.yaml* accordingly 
3. Install the chart with - `helm install webapp ./webapp --values ./webapp/values.yaml`

### Native kubernates YAML files
To deploy the application to you cluster, apply the directory called *raw-manifests* to create a Deployemnt and expose the application with an Ingress-NGINX controller.

`kubectl apply -f ./raw-manifests/`
