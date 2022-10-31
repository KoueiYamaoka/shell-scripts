#!/bin/zsh

TEMPFILE="${HOME}/shellScripts/local/.existemacs"
echo $TEMPFILE
if [ -e $TEMPFILE ]; then # if Emacs does not exist
    emacsclient -e "(delete-frame)" > /dev/null 2>&1
    \rm -f $TEMPFILE
else
    emacsclient -nc -a "" -e "(progn (raise-frame) (x-focus-frame (selected-frame)) (toggle-frame-maximized))" > /dev/null 2>&1
    touch $TEMPFILE
fi
