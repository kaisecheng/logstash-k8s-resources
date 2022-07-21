In this example, Filebeat collect the container log of kube-apiserver and output to Logstash, and then Logstash send the events to Elasticsearch

For the moment, it includes
- Filebeat <> Logstash tls mutual verification
- Logstash <> Elasticsearch tls setup
- Logstash with memory queue scale with hpa

## Deploy the example
```
# prepare cert/key for filebeat <> logstash
./cert/generate_cert.sh

kubectl apply -f .
```

## To clean up the example
```
kubectl delete service,pods,deployment,hpa,configmap,secret,beat,elasticsearch -l app=logstash-demo
```

## Troubleshoot

### Unhealthy Logstash pod

Logstash restarts several times and the readiness probe failed
```
NAMESPACE     NAME                                  READY   STATUS    RESTARTS      AGE
default       logstash-f7768c66d-grzbj              0/1     Running   3 (55s ago)   6m32s
```

Possible solutions
- In logstash.yml, set `api.http.host: 0.0.0.0` to enable health check connection
- Review CPU and memory if they are enough to start Logstash within `initialDelaySeconds`