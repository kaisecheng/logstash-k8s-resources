#!/bin/bash
# this is a script generates secret for keystore

cd "$(dirname "$0")"

kubectl create secret generic logstash-keystore --from-file=logstash.keystore --dry-run=client -o yaml | kubectl label -f- --dry-run=client -o yaml --local app=logstash-demo  > ../001-keystore-secret.yaml