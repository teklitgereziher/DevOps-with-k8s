#!/bin/bash
# Argument validation check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <SECRET_NAME>"
    exit 1
fi
SECRET_NAME=$1
if [ -z "$SECRET_NAME" ]; then
  echo "The argument for SECRET_NAME is empty or null. Please provide the SECRET_NAME."
  exit 1
fi
kubectl create secret generic -n k8stutorial $SECRET_NAME \
  --save-config \
  --dry-run=client \
  --from-file=key.kdb=password.kdb \
  --from-file=key.rdb=password.rdb  \
  --from-file=key.sth=password.sth \
  -o yaml | \
  kubectl apply -f -