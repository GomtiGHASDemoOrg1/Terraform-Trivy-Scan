#!/bin/bash

# Include the "demo-magic" helpers
source demo-magic.sh

DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
TYPE_SPEED=30

function comment() {
  cmd=$DEMO_COMMENT_COLOR$1$COLOR_RESET
  echo -en "$cmd"; echo ""
}

clear

## Check Trivy is installed

comment "# check the Trivy version installed:"
pe 'trivy version'

## Repository Scanning

comment "# scan a remote repository for security issues"
pe 'trivy repo https://github.com/Cloud-Native-Security/website'

comment "# scan a remote repository but specify the branch"
pe 'trivy repo --branch example https://github.com/Cloud-Native-Security/website'
echo

comment "# scan a remote repository, specify the tag"
pe 'trivy repo --tag 0.0.1 https://github.com/Cloud-Native-Security/website'
echo

comment "# scan a remote repository by vulnerability type"
pe 'trivy repo --vuln-type library https://github.com/Cloud-Native-Security/website'
echo

## Filesystem Scanning

comment "# clone an example repo"
pe 'echo "git clone git@github.com:Cloud-Native-Security/website.git"'

comment "# scan the filesystem of the example repository"
pe 'trivy fs ../website'
echo

## Vulnerability Scanning

comment "# scan a container image for security issues"
pe 'trivy image node:20'

comment "# ignore unfixed issues"
pe 'trivy image --ignore-unfixed node:20'
echo

comment "# only show vulnerabilities wit HIGH and CRITICAL severity"
pe 'trivy image --severity HIGH,CRITICAL node:20'
echo

comment "# combine different filters"
pe 'trivy image --severity HIGH,CRITICAL --ignore-unfixed node:20'
echo

## Misconfiguration Scanning

comment "# different misconfiguration files"
pe 'ls ../bad_iac'
echo

comment "# scanning a collection of configuration files for security issues"
pe 'trivy config ../bad_iac/'
echo

comment "# scanning a Dockerfile for security issues"
pe 'trivy config ../bad_iac/docker/'
echo

comment "# scanning a Kubernetes YAML manifest for security issues"
pe 'trivy config ../bad_iac/kubernetes'
echo

comment "# scanning a Kubernetes YAML manifest by severity"
pe 'trivy config --severity HIGH ../bad_iac/kubernetes'
echo

comment "# scanning terraform for security issues"
pe 'trivy config ../bad_iac/terraform'
echo

## Secret Scanning

pe 'echo "The researchers analyzed 337,171 images from Docker Hub and 8,076 private registries and found that more than 1 in 12 of these images contained sensitive information, including private keys and API secrets
https://www.malwarebytes.com/blog/news/2023/07/docker-hub-images-found-to-expose-secrets-and-private-keys"'

comment "# Identify exposed secreats"
pe 'trivy repo --scanners secret https://github.com/Aristat/golang-example-app'
echo

## Kubernetes Scanning

comment "# apply a new Kubernetes app manifest"
pe 'kubectl apply -f ../kubernetes-manifests'
echo

comment "# query all the resources in the trivy system namespace"
pe 'kubectl get all -n trivy-system'
echo

comment "# query all the Vulnerability reports inside the cluster"
pe 'kubectl get Vulnerabilityreports'
echo

comment "#  Enter interactive mode..."
cmd 