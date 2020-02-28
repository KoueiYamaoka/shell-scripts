#!/bin/sh

for i in `seq 1 ${#}`                      # loop for arguments
do                                         # ex) ${1} = test.eps
    fn=`basename ${1} .eps`                # fn = test
    convert -density 600 ${1} ${fn}.pdf    # convert test.eps test.pdf
    shift                                  # go to next argument
done
