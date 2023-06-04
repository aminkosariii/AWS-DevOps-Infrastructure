#!/bin/bash

kubectl create namespace logging

kubectl apply -f elasticsearch.yaml

kubectl apply -f kibana.yaml

kubectl apply -f fluentd.yaml

kubectl apply -f storage.yaml
