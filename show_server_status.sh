#!/bin/bash

DATE=`date +"%Y/%m/%d %H:%M:%S"`
MEM_USED=`free | grep Mem | awk '{ printf("%d", ($2-$7)/$2*100+0.5) }'`%
CPU_USED=`top -b -n 1 | grep Cpu | awk '{ print 100 - $8 }'`%
if hash nvidia-smi 2>/dev/null; then
    GPU_USED=`nvidia-smi | grep Default | awk '{ print $5 }'`
    GPU_USED=`echo $GPU_USED | awk '{ print $1 + $2 + $3 }'`W
else
    GPU_USED='N/A'
fi

echo "$HOSTNAME $DATE"
(
echo "CPU_USED GPU_USED MEMORY_USED"
echo "${CPU_USED} ${GPU_USED} ${MEM_USED}"
) | column -t

