#!/bin/sh

for i in `seq 1 ${#}`                      # loop for arguments
do                                         # ex) ${1} = test.pdf
    fname=`basename ${1} .pdf`             # fname = test
    pdfcrop ${1}                           # pdfcrop
    mkdir ./oldPDFs                        # mkdir oldPDFs
    mv ${1} ./oldPDFs/${fname}_old.pdf     # mv test.pdf oldPDFs/test_old.pdf
    mv ${fname}-crop.pdf ${1}              # mv test-crop.pdf test.pdf
    extractbb ${1}                         # extractbb test.pdf
    shift                                  # go to next argument
done
