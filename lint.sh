#!/bin/bash
ansible-lint test.yaml
if [ "$?" != "0"]; 
then
    echo "bad"
    exit -2
else
    echo "success"
fi
