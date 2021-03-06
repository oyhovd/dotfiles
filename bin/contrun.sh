#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
DARKGRAY='\033[0;90m'
NC='\033[0m' # No Color

CLS='\033c'
#CLS=''

ITERATION=0
PASSED=1
RETRY_NOW=1
SLEEP_TIME=2
SEPARATOR_OFFSET=0
LENGTH_EXPANSION=0
MAX_LINES=0
WRAP_HEADROOM=4

PLUS="+"
MINUS="-"

HELP="Press + or - to adjust sleep time, s to save last log, p to pause, q to quit, e to open last
log in editor, l to view with less. m to show more text, n to show less, M to show max. k to show
more tail, j to show more head, K for all tail and J for all head, S for even split."

#Global
OUTPUT=""

function printoutput {
  echo -e "${DARKGRAY}Formatting result...${NC}"

  SCREEN_LINES=$(tput lines)
  SCREEN_COLS=$(tput cols)
  MAX_CHARS=$(($SCREEN_COLS * 2))
  MAX_SEPARATORS=$(($SCREEN_COLS / 2))
  #MAX_LINES is: 5 reserved for "failed" and help text, 3 reserved for separator, 2 for "Running" and "Formatting...". Subtracting some lines in case of wraps.
  MAX_LINES=$(( ( ($SCREEN_LINES - 5 - 3 - 2)) + ( $LENGTH_EXPANSION * 2) - $WRAP_HEADROOM ))
  HEAD_MAX_LINES=$(( ($MAX_LINES / 2) + $SEPARATOR_OFFSET ))
  TAIL_MAX_LINES=$(( ($MAX_LINES / 2) - $SEPARATOR_OFFSET ))

  #To avoid flickering, build the output in a variable and print it instead of building it on the screen.
  HEAD=$(echo "${OUTPUT}" | head -n $HEAD_MAX_LINES | cut -c -$MAX_CHARS;)
  TAIL=$(echo "${OUTPUT}" | tail -n $TAIL_MAX_LINES | cut -c -$MAX_CHARS;)
  SEPARATOR=""
  for i in `seq 1 $MAX_SEPARATORS`;
  do
    SEPARATOR="$SEPARATOR<>"
  done

  tput clear
  echo "$HEAD"

  tput cup $HEAD_MAX_LINES 0
  tput ed #clear to end of screen
  echo "" #blank line
  tput setaf 3 #set color
  echo "$SEPARATOR"
  tput sgr0 #clear formatting
  echo "" #blank line
  echo "$TAIL"
}
echo -e "${CLS}Starting running of: $@"

while true
do
  ((ITERATION++))

  echo -e "${DARKGRAY}Running command...${NC}"
  OUTPUT=$(nice -n20 $@ 2>&1)

  if [[ $? -ne 0 ]]
  then
    printoutput

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

  REDRAW=0

  while true
  do

    if [[ $RETRY_NOW -ne 0 ]]
    then
      #Sleep nothing when retrying fast.
      THIS_SLEEP_TIME=0
    else
      THIS_SLEEP_TIME=$SLEEP_TIME
    fi

    if [[ $REDRAW -ne 0 ]]
    then
      #Sleep almost nothing when waiting to redraw
      THIS_SLEEP_TIME=0.3
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
    if [[ $key = j ]]
    then
      ((SEPARATOR_OFFSET++))
      echo -e "${CLS}Separator offset: $SEPARATOR_OFFSET"
      #printoutput
      REDRAW=1
      echo ""
      echo $HELP
      continue
    fi
    if [[ $key = J ]]
    then
      SEPARATOR_OFFSET=($MAX_LINES/2)
      SEPARATOR_OFFSET=($SEPARATOR_OFFSET-1)
      echo -e "${CLS}Separator offset: $SEPARATOR_OFFSET"
      #printoutput
      REDRAW=1
      echo ""
      echo $HELP
      continue
    fi
    if [[ $key = k ]]
    then
      ((SEPARATOR_OFFSET--))
      echo -e "${CLS}Separator offset: $SEPARATOR_OFFSET"
      #printoutput
      REDRAW=1
      echo ""
      echo $HELP
      continue
    fi
    if [[ $key = K ]]
    then
      SEPARATOR_OFFSET=($MAX_LINES/-2)
      echo -e "${CLS}Separator offset: $SEPARATOR_OFFSET"
      #printoutput
      REDRAW=1
      echo ""
      echo $HELP
      continue
    fi
    if [[ $key = S ]]
    then
      SEPARATOR_OFFSET=0
      echo -e "${CLS}Separator offset: $SEPARATOR_OFFSET"
      #printoutput
      REDRAW=1
      echo ""
      echo $HELP
      continue
    fi
    if [[ $key = m ]]
    then
      ((LENGTH_EXPANSION++))
      echo -e "${CLS}Length expansion: $LENGTH_EXPANSION"
      #printoutput
      REDRAW=1
      echo ""
      echo $HELP
      continue
    fi
    if [[ $key = M ]]
    then
      LENGTH_EXPANSION=($WRAP_HEADROOM/2)
      echo -e "${CLS}Length expansion: $LENGTH_EXPANSION"
      #printoutput
      REDRAW=1
      echo ""
      echo $HELP
      continue
    fi
    if [[ $key = n ]]
    then
      ((LENGTH_EXPANSION--))
      echo -e "${CLS}Length expansion: $LENGTH_EXPANSION"
      #printoutput
      REDRAW=1
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
    if [[ $REDRAW = 1 ]]
    then
      printoutput
      REDRAW=0
    fi

    break
  done

done

