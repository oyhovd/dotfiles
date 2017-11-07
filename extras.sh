#!/bin/sh

last_invalid()
{
  if [ $? -ne 0 ]; then
    echo "Last command failed. Press ENTER to continue or Ctrl-C to quit."
    read DUMMY
  fi
}

exists()
{
  command -v $1 >/dev/null 2>&1
}

#other installs
if exists pip3; then
  sudo pip3 install thefuck
  last_invalid
fi

if exists pip; then
  pip install matplotlib
  last_invalid
fi

echo "Setup done"

