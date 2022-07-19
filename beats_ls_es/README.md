In this example, Filebeat collect the container log of kube-apiserver and output to Logstash, and then Logstash send the events to Elasticsearch

For the moment, it includes
- Filebeat <> Logstash tls mutual verification
- Logstash <> Elasticsearch tls setup
- Logstash with memory queue scale with hpa

## Tips
1. Set logstash.yml `api.http.host: 0.0.0.0` to enable health check connection
2. Cheatsheet of generating certificate for Filebeat and Logstash

```
cd cert

# generate ca
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -sha256 -out ca.crt -subj "/C=EU/ST=NA/O=Elastic/CN=RootCA"

# generate logstash cert
openssl genrsa -out server.key 2048
openssl req -sha512 -new -key server.key -out server.csr -subj "/C=EU/ST=NA/O=Elastic/CN=ServerHostName"
openssl x509 -days 3650 -req -sha512 -in server.csr -CAcreateserial -CA ca.crt -CAkey ca.key -out server.crt -extensions server_cert -extfile openssl.conf
openssl pkcs8 -in server.key -topk8 -nocrypt -out server.pkcs8.key

# generate beats cert
openssl genrsa -out client.key 2048
openssl req -sha512 -new -key client.key -out client.csr -subj "/C=EU/ST=NA/O=Elastic/CN=ClientName"
openssl x509 -days 3650 -req -sha512 -in client.csr -CAcreateserial -CA ca.crt -CAkey ca.key -out client.crt -extensions client_cert -extfile openssl.conf

# generate secret.yaml
kubectl create secret generic logstash-beats-tls --from-file=ca.crt --from-file=client.crt --from-file=client.key --from-file=server.crt --from-file=server.pkcs8.key --dry-run=client --output=yaml > 001-secret.yaml
```

3. You should not use the demo certificate in production