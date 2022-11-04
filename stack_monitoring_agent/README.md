Work in progress...

Stack monitoring does not work.

kubectl delete elasticsearch elasticsearch
kubectl delete kibana kibana
kubectl delete agent elastic-agent
kubectl delete sa,clusterrole,clusterrolebinding elastic-agent
kubectl delete service,pods,deployment,hpa,configmap,secret -l app=ls