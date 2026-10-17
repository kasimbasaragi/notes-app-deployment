#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if grep -q YOUR_DOCKERHUB_USERNAME k8s/06-app-deployment.yml; then
  echo "STOP: open k8s/06-app-deployment.yml and set your Docker Hub username and image tag."
  exit 1
fi

if [ ! -f secrets/secret.yml ]; then
  cp secrets/secret.example.yml secrets/secret.yml
  echo "Created secrets/secret.yml from the example."
  echo "Edit the passwords in it if you want, then run ./deploy.sh again."
  exit 1
fi

kubectl apply -f k8s/00-namespace.yml
kubectl apply -f secrets/secret.yml
kubectl apply -f k8s/
kubectl rollout status deploy/db -n notes-dev --timeout=180s
kubectl rollout status deploy/notes-app -n notes-dev --timeout=180s
kubectl get all,pv,pvc -n notes-dev
