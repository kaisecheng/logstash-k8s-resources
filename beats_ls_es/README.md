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

Add install command in `Deployment`
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

In test environment, you can connect the host's Elasticsearch from Logstash in kubernetes.
- Set Logstash Deployment `spec.template.spec.hostNetwork` to `true`
- Add Elasticsearch CA cert to Secret. `kubectl create secret generic es-certs --from-file=ca.crt=/YOUR/ELASTICSEARCH/PATH/config/certs/http_ca.crt`
- Mount the Secret `es-certs` to Logstash Deployment
  ```
          volumeMounts:
            - name: es-certs
              mountPath: /usr/share/logstash/config/ca.crt
              subPath: ca.crt
    volumes:
      - name: es-certs
        secret:
          secretName: es-certs
  ```
- Connect Elasticsearch with IP
  ```
  elasticsearch { 
    hosts => ["https://192.168.1.70:9200"]
    cacert => "/usr/share/logstash/config/ca.crt"
    user => 'elastic'
    password => 'ELASTICSEARCH_PASSWORD'
  }
  ```

## Connect to Elastic Cloud Elasticsearch

Config cloud endpoint and username and password to `elasticsearch { }` 

## Autoscaling

To scale Logstash with memory queue, tune the target CPU and memory of `HorizontalPodAutoscaler`.