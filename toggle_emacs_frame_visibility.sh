#!/bin/zsh

# toggle main frame possition (front or back)
TEMPFILE="${HOME}/shellScripts/local/.emacsraised"
if [ -e $TEMPFILE ]; then # if Emacs raised
    emacsclient -e '(progn (select-frame-by-name "main frame") (lower-frame))' > /dev/null 2>&1
    TMP=$?
    \rm -f $TEMPFILE
else
    emacsclient -e '(progn (select-frame-by-name "main frame") (raise-frame))' > /dev/null 2>&1
    TMP=$?
    touch $TEMPFILE
fi

# if main frame does not exist
if [ $TMP -eq 1 ]; then
    emacsclient -nc -a "" -e "(progn (select-frame-set-input-focus (selected-frame)) (toggle-frame-maximized))" -F '(quote (name . "main frame"))'
fi

