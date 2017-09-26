#!/bin/bash

#This line must exit successfully, or else we tag the revision as "skipped"
#e.g. grep fisk test.sh

if [[ $? -ne 0 ]]
then
  exit 125 # To git bisect run, this means that the revision shall be skipped.
fi

#The real test: If this line exits successfully, it is a good revision. Else it is a bad revision.
#e.g. test.sh

exit $?


