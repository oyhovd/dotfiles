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

sudo apt-get install -y minicom python3-tk dos2unix
sudo usermod -aG dialout $(whoami)

if exists pip; then
  pip install matplotlib
  last_invalid
fi

if exists pip3; then
  pip3 install matplotlib
  last_invalid
fi

echo "Setup done"

