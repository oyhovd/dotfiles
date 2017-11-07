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

if exists apt-get; then
  sudo apt-get -y install build-essential module-assistant
  last_invalid
fi

m-a prepare
last_invalid

echo "Click on Install Guest Additions... from the Devices menu, then press enter to continue"
read

mount /media/cdrom
last_invalid

sh /media/cdrom/VBoxLinuxAdditions.run
last_invalid

echo "Setup done"

