#!/bin/bash

#This line must exit successfully else we tag the revision as "skipped"
grep fisk test.sh

if [[ $? -ne 0 ]]
then
  exit 125
fi

#The real test: If this line exits successfully, it is a good revision. Else..
source test.sh

exit $?


