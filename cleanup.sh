#!/usr/bin/env bash
cd "$(dirname "$0")"
kubectl delete -f k8s/ --ignore-not-found
kubectl delete -f secrets/secret.yml --ignore-not-found
echo "Database data is kept in /data/pgdata on the minikube node (PV uses Retain)."
