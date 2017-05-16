#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

CLS='\033c'
#CLS=''

ITERATION=0
PASSED=1
RETRY_NOW=1
SLEEP_TIME=2

PLUS="+"
MINUS="-"

HELP="Press + or - to adjust sleep time, s to save last log, p to pause, q to quit, e to open last 
log in editor, l to view with less."

echo -e "${CLS}Starting running of: $@"

while true
do
  ((ITERATION++))

  SCREEN_LINES=$(tput lines)
  OUTPUT=$(nice -n20 $@ 2>&1)

  if [[ $? -ne 0 ]]
  then
    echo -e "${CLS}"
    #To avoid flickering, build the output in a variable and print it instead of building it on the screen.
    RESULT_TO_PRINT=$(echo "${OUTPUT}" | head -n 20 | cut -c -200; echo ""; echo "<><><><><><><><><><><><><><><><><><><><><><>"; echo ""; echo "${OUTPUT}" | tail -n 20 | cut -c -200)
    echo "${RESULT_TO_PRINT}"
#    echo "${OUTPUT}"
    echo "" #newline
    echo -e "${RED}Iteration $ITERATION Failed: ${NC}$@"

    #if first failure, retry immediately the first few times
    if [[ $PASSED -ne 0 ]]
    then
      RETRY_NOW=3
    else
      if [[ $RETRY_NOW -ne 0 ]]
      then
        ((RETRY_NOW--))
      fi
    fi

    PASSED=0
  else
    echo -e "${CLS}${GREEN}Iteration $ITERATION Passed: ${NC}$@"
    PASSED=1
    RETRY_NOW=0
  fi

  echo ""
  echo $HELP

  while true
  do
    if [[ $RETRY_NOW -ne 0 ]]
    then
      #Sleep nothing when retrying fast.
      THIS_SLEEP_TIME=0
    else
      THIS_SLEEP_TIME=$SLEEP_TIME
    fi

    if [[ $THIS_SLEEP_TIME -eq 0 ]]
    then
      THIS_SLEEP_TIME=0.01
    fi

    read -t $THIS_SLEEP_TIME -n 1 -s key

    if [[ $key = + ]]
    then
      if [[ $SLEEP_TIME -lt 60 ]]
      then
        ((SLEEP_TIME++))
      fi
      echo -e "${CLS}Sleeping $SLEEP_TIME seconds"
      echo ""
      echo $HELP
      continue
    fi
    if [[ $key = - ]]
    then
      if [[ $SLEEP_TIME -gt 0 ]]
      then
        ((SLEEP_TIME--))
      fi
      echo -e "${CLS}Sleeping $SLEEP_TIME seconds"
      echo ""
      echo $HELP
      continue
    fi
    if [[ $key = s ]]
    then
      DATE=$(date +%Y-%m-%d_%H%M%S)
      LOGFILE="contrun_$DATE.log"
      echo -e "Saving log to $LOGFILE"
      echo "$OUTPUT" > $LOGFILE
      continue
    fi
    if [[ $key = p ]]
    then
      echo "Paused. Press any key to continue."
      read -n 1
      echo ""
      echo "Continuing."
    fi
    if [[ $key = q ]]
    then
      exit
    fi
    if [[ $key = l ]]
    then
      echo "$OUTPUT" | less
      echo "Continuing."
    fi
    if [[ $key = e ]]
    then
      echo "$OUTPUT" | vim -m -
      echo "Continuing."
    fi
    break
  done

done

