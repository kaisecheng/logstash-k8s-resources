# Deploy logstash to Kubernetes

This repository used for demo purpose. It includes a collection of Logstash setup connecting to Elastic stack in Kubernetes.

- filebeat -> logstash -> elasticsearch

# How to run

Install Elastic CRD
```
helm repo add elastic https://helm.elastic.co && helm repo update
helm install elastic-operator elastic/eck-operator
```

Deploy the example
```
kubectl apply -f ./beats_ls_es
```

To clean up the example
```
kubectl delete all -l app=logstash-demo
```

The demo is tested in minikube kubernetes 1.23
