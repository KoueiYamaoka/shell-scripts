#!/bin/bash

## parameters
# list of environments to be removed; contentx are not removed
readonly ENV=(itemize enumerate description abstract document)

# list of environments to be removed; contentx are also removed
readonly ENV_RM=(align figure table keywords)

# list of commands to be removed; arguments are not removed
readonly CMD=(ref eqref ac acl acp subsecref)

# list of commands to be removed; arguments are also removed
readonly CMD_RM=(par renewcommand label usepackage newcommand newtheorem def input maketitle acresetall clearpage newpage bibliographystyle bibliography)

# list of commands for citation
readonly CITE=(cite)

# if true, remove text from documentclass to \begin{document} (true or false)
readonly IS_RM_PREAMBLE=true

# if true, remove $ (true or false)
readonly RM_DOLLAR=true

# if true, remove $$ (true or false)
readonly RM_DOLLAR_DOLLAR=true

# if true, remove \n\n* (true or false)
readonly RM_NEW_LINES=true

# mark that is used instead of \item
readonly MARK=*

# characters to be replaced to white space
readonly CHAR=('~')


## main
fname=`basename ${1} .tex`
cp ${fname}.tex ${fname}.txt

# remove header
if $IS_RM_PREAMBLE; then
   sed -i -e '/\\documentclass/,/\\begin{document}/d' ${fname}.txt
fi

# remove environments while remaining arguments
for i in ${ENV[@]}
do
    sed -i -e 's/\\\(begin\|end\){'"${i}"'}//g' ${fname}.txt
done

# remove environments
for i in ${ENV_RM[@]}
do
    sed -i -e '/\\begin{'"${i}"'}/,/\\end{'"${i}"'}/d' ${fname}.txt
done

# remove command while remaining arguments
for i in ${CMD[@]}
do
    sed -i -e 's/\\'"${i}"'{\([^}]*\)}/\1/g' ${fname}.txt
done

# remove command
for i in ${CMD_RM[@]}
do
    sed -i -e 's/\\'"${i}"'\([^ ]*\)//g' ${fname}.txt
done

# dealing with citation
for i in ${CITE[@]}
do
    sed -i -e 's/\\'"${i}"'{\([^}]*\)}/[\1]/g' ${fname}.txt
done

# remove $$
if $RM_DOLLAR; then
    sed -i -e '/\$\$/,/\$\$/d' ${fname}.txt
fi

# remove $
if $RM_DOLLAR; then
    sed -i -e 's/\$//g' ${fname}.txt
fi

# dealing with citation
for i in ${CITE[@]}
do
    sed -i -e 's/\\'"${i}"'{\([^}]*\)}/[\1]/g' ${fname}.txt
done

# remove characters
for i in ${CHAR[@]}
do
    sed -i -e "s/${i}/ /g" ${fname}.txt
done

# convert \item to $MARK
sed -i -e 's/\\item/'"${MARK}"'/g' ${fname}.txt

# remove comments
sed -i -e '/.*%/d' ${fname}.txt

# remove new lines
if $RM_NEW_LINES; then
    sed -i -e ':cl;N;$!b cl;s/\n\{3,\}/\n/g' ${fname}.txt
fi
