## Repository to demo Trivy

This repository provides several examples, showcasing Trivy. Trivy is an open source security scanner.

### Resources
- GitHub repository: https://github.com/aquasecurity/trivy
- Documentation: https://aquasecurity.github.io/trivy/latest/
- Slack Channel: https://slack.aquasec.com

### Presentations
- Container Security on AKS with AquaSecurity OSS: https://youtu.be/a6iUUWqJDg0?t=297

## Trivy CLI

Installation options: https://aquasecurity.github.io/trivy/latest/getting-started/installation/

Below are some of the commands that can be used through the Trivy CLI.

### Vulnerability Scans

Scan a container image for vulnerabilities:
```
trivy i ubuntu:20.04
```

Scan a container image for vulnerabilities but ignore all vulnerabilities that do not have a fix available:
```
trivy i --ignore-unfixed ubuntu:20.04
```

Scan a container image for vulnerabilities but filter for HIGH and CRITICAL vulnerabilities
```
trivy image --severity HIGH,CRITICAL --vuln-type os postgres:10.6
```

Scan any GH repository for vulnerabilities:
```
trivy repo --vuln-type library https://github.com/raesene/sycamore
```

Scan any filesystem for vulnerabilities:
```
git clone https://github.com/raesene/sycamore
trivy fs ./sycamore/
```

### Misconfiguration Scans

Scan all of your infrastructure configuration for vulnerabilities:
```
ls trivy-demo/bad_iac
```

Scan your Dockerfile for vulnerabilities and misconfigurations:
```
trivy config trivy-demo/bad_iac/docker/
```

Scan your Kubernetes manifests for vulnerabilities and misconfigurations:
```
trivy config trivy-demo/bad_iac/kubernetes
```

Scan your Terraform for vulnerabilities and misconfigurations:
```
trivy config trivy-demo/bad_iac/terraform
```

### Scan your connected Kubernetes cluster

The Trivy Kubernetes command scans any connected Kubernetes cluster for vulnerabilities, misconfigurations, exposed secrets and more.

To scan your entire cluster and receive a summary report use the following command:

```
trivy k8s --report=summary
```

To scan a specific namespace in your cluster and receive a summary report use the following command:
```
trivy k8s -n kube-system --report=summary
```

To receive a detailed report, you can use the `--report=all` flag. However, we would advice to only do that on specific namespaces or resources since you will be provided with a lot of detailed information:
```
trivy k8s -n kube-system --report=all
```

Similar to vulnerabilities, we can also filter in-cluster for specific vulnerabilty types:
```
trivy k8s --severity=CRITICAL --report=all​
```

With the trivy K8s command, you can also scan specific workloads that are running within your cluster:
```
trivy k8s –n default --report=summary deployments/react-application
```

## Trivy Operator

While you would use the Trivy CLI on your local machine or from within a CI/CD pipeline, the Trivy operator is installed inside your Kubernetes cluster. From there, it performs continuous scanning of your Kuberentes resources.
Have a look at the documentation for more information:

Installation options:

### Scan your connected Kubernetes cluster

Once the operator is installed, you will see it running in the Trivy System namespace:
```
kubectl get all -n trivy-system
```

Now, we can install a deployment. If you do not have a deployment within your cluster, you can use our example application:
```
kubectl apply -f manifests 
```

Trivy will then automatically scan new deployments:
```
kubectl get Vulnerabilityreports
```

To get detailed information on the vulnerabilities, describe the Vulnerabilityreports:
```
kubectl describe Vulnerabilityreports replicaset-react-application-79694589b9-react-application
```

