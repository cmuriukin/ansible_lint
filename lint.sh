#!/bin/bash
ansible-lint nginx.yaml
if [ "$?" != "0"]; 
then
    echo "bad"
    exit -2
else
    echo "success"
fi
