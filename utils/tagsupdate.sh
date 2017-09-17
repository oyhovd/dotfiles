#!/bin/sh

TEMPTAGS=`mktemp tags.XXXXXX`
ctags -R -f $TEMPTAGS .
mv -f $TEMPTAGS tags
