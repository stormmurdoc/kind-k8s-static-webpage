# Kubernetes in Docker (KinD)

This project compiles a local Docker container and then deploys it to the
kind cluster. Afterwards, the application and the service are deployed
in the KinD-k8s cluster.

## Prerequisites

The following components must be installed:

- docker
- kind
- kubectl

## Deploy

![image_2021-11-01-16-48-39](img/image_2021-11-01-16-48-39.png)

Start the deployment with

        deploy.sh

## Destroy cluster
Getting rid of a KinD cluster

        kind delete cluster


## kubectl

        kubectl get all -A

![image_2021-11-01-16-59-07,p](img/image_2021-11-01-16-59-07.png)
