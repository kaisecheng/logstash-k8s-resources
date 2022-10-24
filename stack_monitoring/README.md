This example modifies the stack monitoring recipes from https://raw.githubusercontent.com/elastic/cloud-on-k8s/2.4/config/recipes/beats/stack_monitoring.yaml

The recipe has initiated a production elasticsearch cluster, a monitoring elasticsearch cluster, filebeat, metricbeat, a production Kibana and a monitoring Kibana. 

We use metricbeat autodiscover to monitor multiple Logstash.

## Set up
There are two elasticsearch clusters.
For data in Kibana show in the right cluster, config logstash.yml `monitoring.cluster_uuid` with the uuid of the production elasticsearch cluster.

```
apiVersion: v1
data:
  logstash.yml: |
    api.http.host: "0.0.0.0"
    monitoring.cluster_uuid: # YOUR PRODUCTION ES CLUSTER UUID
kind: ConfigMap
```

## Deploy the example
```
kubectl apply -f .
```

## Clean up the example
```
kubectl delete pods,deployment,configmap -l app=ls
kubectl delete elasticsearch elasticsearch-monitoring elasticsearch
kubectl delete kibana kibana-monitoring kibana
kubectl delete beat filebeat metricbeat
kubectl delete sa,clusterrole,clusterrolebinding filebeat metricbeat
```
