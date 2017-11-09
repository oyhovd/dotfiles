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

sudo apt-get install -y minicom

if exists pip; then
  pip install matplotlib
  last_invalid
fi

echo "Setup done"

