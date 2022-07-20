# Deploy logstash to Kubernetes

This repository used for demo purpose. It includes a collection of Logstash setup connecting to Elastic stack in Kubernetes.

- filebeat -> logstash -> elasticsearch
- logstash with persistent queue -> elasticsearch

# Prerequisite

Install Elastic CRD
```
helm repo add elastic https://helm.elastic.co && helm repo update
helm install elastic-operator elastic/eck-operator
```

# How to run

Please check the readme in the folder

The demo is tested in minikube kubernetes 1.23
