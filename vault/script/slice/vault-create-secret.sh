#!/bin/sh
ff=$(basename "$1")
fp=$(dirname "$1")
echo "Writing file name content : $1"
fileWithoutPrefix="${1%.*}"
secretBasePath=$VAULT_DATA_PATH/secret/json
offset=${#secretBasePath}
secretPath=${fileWithoutPrefix:$offset}
echo "Secret path is : "${secretPath}
echo "Checking secret exists : $secretPath"
ar=$(vault read /secret/$secretPath | grep Key | wc -c)
if [ $ar != 0 ]
then
	echo "secret '$secretPath' already exists."
	exit 1;
fi
vault write -format=json /secret/$secretPath @$1