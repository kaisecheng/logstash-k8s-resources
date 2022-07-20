In this example, Filebeat collect the container log of kube-apiserver and output to Logstash, and then Logstash send the events to Elasticsearch

For the moment, it includes
- Filebeat <> Logstash tls mutual verification
- Logstash <> Elasticsearch tls setup
- Logstash with memory queue scale with hpa

Deploy the example
```
./cert/generate_cert.sh
kubectl apply -f .
```

To clean up the example
```
kubectl delete all -l app=logstash-demo
```

## Troubleshoot
1. Set logstash.yml `api.http.host: 0.0.0.0` to enable health check connection