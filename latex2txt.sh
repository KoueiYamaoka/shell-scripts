#!/bin/bash

## parameters
# list of environments to be removed; contents are not removed
ENV=(itemize enumerate description abstract)

# list of environments to be removed; contents are removed
ENV_RM=(align figure "figure*" table "table*" keywords)

# list of reference commands to be removed
REF_CMD=(ref eqref figref tblref secref)

# list of commands to be removed; arguments are not removed
CMD=(ac acl textbf textit textrm textsc textsf textsl texttt gls Gls)
CMD_PLURAL=(acp glspl)

# list of commands to be removed; arguments are removed
CMD_RM=(par renewcommand label usepackage newcommand newtheorem def input maketitle acresetall clearpage newpage bibliographystyle bibliography vspace hspace plabel)

# list of commands for citation
CITE=(cite)

# if true, remove text in the line from documentclass to \begin{document} (true or false)
IS_RM_PREAMBLE=true

# if true, remove $ (true or false)
RM_DOLLAR=true

# if true, remove $$ (true or false)
RM_DOLLAR_DOLLAR=true

# if true, remove \n\n* (true or false)
RM_NEW_LINES=true

# mark that is used instead of \item
MARK=*

# characters to be replaced to white space
CHAR=('~')


## main
fname=`echo ${1} | sed 's/\.[^\.]*$//'`

# remove header
if $IS_RM_PREAMBLE; then
    sed -e '/\\documentclass/,/\\begin{document}/d' ${fname}.tex > ${fname}.txt
    sed -i -e '/\\end{document}/d' ${fname}.txt
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

# remove reference commands
for i in ${REF_CMD[@]}
do
    sed -i -e 's/\\'"${i}"'{\([^}]*\)}/\\'"${i}"'/g' ${fname}.txt
done

# remove command while remaining arguments
for i in ${CMD[@]}
do
    sed -i -e 's/\\'"${i}"'{\([^}]*\)}/\1/g' ${fname}.txt
done
for i in ${CMD_PLURAL[@]}
do
    sed -i -e 's/\\'"${i}"'{\([^}]*\)}/\1s/g' ${fname}.txt
done

# remove command
for i in ${CMD_RM[@]}
do
    sed -i -e 's/\\'"${i}"'\([^ ]*\)//g' ${fname}.txt
done

# dealing with citation
for i in ${CITE[@]}
do
    # sed -i -e 's/\\'"${i}"'{\([^}]*\)}/[\1]/g' ${fname}.txt
    sed -i -e 's/\\'"${i}"'{\([^}]*\)}//g' ${fname}.txt
done

# remove $$
if $RM_DOLLAR; then
    sed -i -e '/\$\$/,/\$\$/d' ${fname}.txt
fi

# remove $
if $RM_DOLLAR; then
    sed -i -e 's/\$//g' ${fname}.txt
fi

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
