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

## Clean up the example
```
kubectl delete service,pods,deployment,hpa,configmap,secret,beat,elasticsearch -l app=logstash-demo
```

## Install plugin
```
  image: "docker.elastic.co/logstash/logstash:8.3.2"
  command: ["/bin/bash", "-c"]
  args:
    - |
      set -e
      bin/logstash-plugin install logstash-output-google_bigquery
      /usr/local/bin/docker-entrypoint
```

## Connect to local Elasticsearch 

## Connect to Elastic Cloud


