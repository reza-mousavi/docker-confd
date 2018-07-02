#!/bin/sh
echo "Initializing policies..."
for entry in "$VAULT_DATA_PATH"/policy/hcl/*
do
  echo "Applying policy $entry"
  $VAULT_SCRIPT_PATH/slice/vault-create-policy.sh $entry
done