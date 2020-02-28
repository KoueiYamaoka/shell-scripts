#!/bin/sh

for i in `seq 1 ${#}`                               # loop for arguments
do                                                  # ex) ${1} = test.pdf
    fname=`basename ${1} .pdf`                      # fname = test
    ~/shellScripts/pdf_reduce_once.sh ${1} tmp.pdf  # pdf_reduce test.pdf tmp.pdf
    mkdir -p ./oldPDFs                              # mkdir oldPDFs
    mv ${1} ./oldPDFs/${fname}_old.pdf              # mv test.pdf oldPDFs/test_old.pdf
    mv tmp.pdf ${1}                                 # mv tmp.pdf test.pdf
    shift                                           # go to next argument
done
