#!/bin/sh
ff=$(basename "$1")
fn="${ff%.*}"
echo "Checking policy exists : $fn"
ar=$(vault read sys/policy/$fn | grep Key | wc -c)
if [ $ar != 0 ]
then
	echo "Policy '$fn' already exists."
	exit 1;
fi
vault policy write $fn $1