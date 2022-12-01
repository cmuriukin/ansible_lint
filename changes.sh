#!/bin/bash
errno=0
while read -d $'\0' -r file; do
    # file has a .yaml extention
    ext=${file:(-5)}
    [[ $ext != ".yaml" ]] && continue
    ansible-lint $file
    err=$?
    if [[ $err != "0" ]]; then
        errno=$err
    fi
done < <(git diff --name-only -z HEAD 'HEAD^1')

exit $errno

#!/bin/bash

# errno=0
# while read -d $'\0' -r file
# do
# 	# file has a .yaml extention
#     ext=${file:(-5)}
#     [[ $ext != ".yaml" ]] && continue
#     ./ansible-lint $file

#     err=$?
#     if [[ $err != "0" ]]
#     then
#     	errno=$err
#     fi
# done < <(git diff --name-only -z HEAD 'HEAD^1')

# exit $errno
