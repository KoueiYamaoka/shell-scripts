#!/bin/sh

if [ $# -lt 1 ]; then
    echo "no argument"
else
    grep $* ~/Documents/dictionary/gene.txt -A 1 -wi --color
fi
