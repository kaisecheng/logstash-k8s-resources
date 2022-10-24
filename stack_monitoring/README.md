This example modifies the stack monitoring recipes from https://raw.githubusercontent.com/elastic/cloud-on-k8s/2.4/config/recipes/beats/stack_monitoring.yaml

The recipe has initiated a production elasticsearch cluster, a monitoring elasticsearch cluster, filebeat, metricbeat, a production Kibana and a monitoring Kibana. 

We use metricbeat autodiscover to monitor multiple Logstash.

## Deploy the example
```
kubectl apply -f .
```

## Set up (Optional)
There are two elasticsearch clusters.
For Logstash metrics in Kibana show in the right cluster, config logstash.yml `monitoring.cluster_uuid` with the uuid of the production elasticsearch cluster.

```
apiVersion: v1
data:
  logstash.yml: |
    api.http.host: "0.0.0.0"
    monitoring.cluster_uuid: # YOUR PRODUCTION ES CLUSTER UUID
kind: ConfigMap
```
## Access Monitoring Kibana

Port forwarding kibana port 5601 and open https://localhost:5601/
```
kubectl port-forward service/kibana-monitoring-kb-http 5601
```

Login as the elastic user. The password can be obtained with the following command
```
kubectl get secret elasticsearch-monitoring-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
```

## Clean up the example
```
kubectl delete pods,deployment,configmap -l app=ls
kubectl delete elasticsearch elasticsearch-monitoring elasticsearch
kubectl delete kibana kibana-monitoring kibana
kubectl delete beat filebeat metricbeat
kubectl delete sa,clusterrole,clusterrolebinding filebeat metricbeat
```
