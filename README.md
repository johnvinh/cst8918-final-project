# Terraform Azure AKS Weather App Deployment
This repository contains the infrastructure code and application code for deploying the Remix Weather Application to Azure Kubernetes Service (AKS) using Terraform and GitHub Actions.
## Team Members
- [Elmotasembel Riyani](https://github.com/Elmo-Riyani)
- [John Vinh](https://github.com/johnvinh)
- [Princeadrian Felix](https://github.com/princefelix-23)
- [Thihanh Tran](https://github.com/tran0507)

## GitHub link 

https://github.com/johnvinh/cst8918-final-project

## Instructions to run the application: 

Part 1: Terraform Setup 
1. Setup Backend (Blob storage)
2. Setup Networking 
3. Setup redis 
4. Deploy AKS 
5. Deploy ACR and Remix App 

Part 2: Setup GitHub Actions


Part 3: Test the application
1. Get external IP of AKS Loadbalancer: 
"" bash 
kubectl get svc -n default

2. Open in browser

http://<external-IP>
