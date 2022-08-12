#!/bin/bash

shift
for host in "{server names}";
do
    STATUS=`ssh $USER@$host.local show_server_status`

    echo "$STATUS" | head -1
    (
        echo "$STATUS" | head -2 | tail -1
        echo "$STATUS" | head -3 | tail -1
    ) | column -t
    echo
done
