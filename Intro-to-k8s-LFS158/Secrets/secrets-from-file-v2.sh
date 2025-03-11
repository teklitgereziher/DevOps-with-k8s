#!/bin/bash
# Argument validation check begins
if [ "$#" -ne 2 ]; then
	echo "Error: All required arguments not provided."
    echo "Expected: $0 <SECRET_NAME> <DIRECTORY_OF_CERTIFICATES>"
    exit 1
fi
SECRET_NAME=$1
CERTS_DIR=$2
# Check if SECRET_NAME is provided
if [ -z "$SECRET_NAME" ]; then
  echo "Error: Please provide the SECRET_NAME."
  exit 1
fi
# Check if Directory of the certificates is provided
if [ -z "$CERTS_DIR" ]; then
  echo "Error: Directory of the certificates not provided."
  exit 1
fi
# Check if Directory is valid
if [ "$CERTS_DIR" = "." ]; then
  CERTS_DIR=""
elif [ -d "$CERTS_DIR" ]; then
  CERTS_DIR="$CERTS_DIR/"
else
  echo "$CERTS_DIR is not a directory."
  exit 1
fi
# Argument validation check ends
kubectl create secret generic -n k8stutorial $SECRET_NAME-secret \
  --save-config \
  --dry-run=client \
  --from-file=key.kdb=$CERTS_DIR"key.kdb" \
  --from-file=key.rdb=$CERTS_DIR"key.rdb"  \
  --from-file=key.sth=$CERTS_DIR"key.sth" \
  -o yaml | \
  kubectl apply -f -
