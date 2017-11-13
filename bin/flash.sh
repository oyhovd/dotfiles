#!/bin/bash

if [[ $# -lt 1 ]]
then
  echo "Pass hex(es) as argument"
  exit 1
fi

#grepping to strip of newlines etc that bash doesn't handle well
SEGNRS=($(nrfjprog -i | grep -e "\w"))

if [[ ${#SEGNRS[@]} -ne 1 ]]
then
  for I in "${!SEGNRS[@]}"
  do
    echo "[$I]: ${SEGNRS[$I]}"
  done

  if [[ ${#SEGNRS[@]} -eq 1 ]]
  then
    SEGNR_IDX=0
  else
    echo "Which segger nr? (${SEGNRS[0]})"
    read SEGNR_IDX
    if [[ SEGNR_IDX -eq "" ]]
    then
      SEGNR_IDX=0
    fi
  fi

  echo "Using segger nr ${SEGNRS[$SEGNR_IDX]}"
  echo ""
fi

FAMILIES=(nrf51 nrf52)

#Trying to get family automagically from 3 first segger digits
SEGNR=${SEGNRS[$SEGNR_IDX]}
FIRST_DIGITS=${SEGNR:0:3}

if [[ ${FIRST_DIGITS} -eq 684 ]]
then
  FAMILY=1
fi

if [[ ${FIRST_DIGITS} -eq 683 ]]
then
  FAMILY=1
fi

if [[ ${FIRST_DIGITS} -eq 682 ]]
then
  FAMILY=1
fi

if [[ $FAMILY = "" ]]
then

  for I in "${!FAMILIES[@]}"
  do
    echo "[$I]: ${FAMILIES[$I]}"
  done

  echo "Which family? (nrf52)"
  read FAMILY
  if [[ $FAMILY = "" ]]
  then
    FAMILY=1 #nrf52
  fi
  echo "Using family ${FAMILIES[$FAMILY]}"
  echo ""
fi

COMMAND="nrfjprog --family ${FAMILIES[$FAMILY]} --snr $SEGNR -e"
echo $COMMAND
eval $COMMAND

for I in "${@}"
do
  COMMAND="nrfjprog --family ${FAMILIES[$FAMILY]} --snr $SEGNR --program $I"
  echo $COMMAND
  eval $COMMAND
done

COMMAND="nrfjprog --family ${FAMILIES[$FAMILY]} --snr $SEGNR -r"
echo $COMMAND
eval $COMMAND

