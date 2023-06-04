#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/bundle.yaml

kubectl apply -f prometheus.yaml

helm repo add grafana https://grafana.github.io/helm-charts

helm install grafana grafana/grafana --values values.yaml

kubectl apply -f servicemonitor.yaml

GRAFANA_URL=$(kubectl get svc grafana -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "Grafana URL: http://$GRAFANA_URL"

open "http://$GRAFANA_URL"
