#!/bin/sh
vault operator unseal ${VAULT_UNSEAL_KEY}
vault login ${VAULT_TOKEN_KEY}