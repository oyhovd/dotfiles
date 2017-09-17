#!/bin/sh

if [ -f "tags" ]; then
  TEMPTAGS=`mktemp tags.XXXXXX`
  #find . -mmin +1 -name "tags.*" -exec rm {} +
  #Not sure why we need to sleep, but seems like ctags is not done with the file
  #when it returns
  ctags -R -f $TEMPTAGS .
  sleep 1
  mv -f $TEMPTAGS tags
  #nohup ctags -R -f $TEMPTAGS . && sleep 1 && mv -f $TEMPTAGS tags
  #(ctags -R -f $TEMPTAGS . && sleep 1 && mv -f $TEMPTAGS tags) &
  #disown
fi
