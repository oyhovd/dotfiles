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
  sudo apt-get update
  sudo apt-get -y install build-essential module-assistant
  last_invalid
fi

#Preparing kernel headers. -i to be non-interactive.
sudo m-a -i prepare
last_invalid

#reading into dummy variable (or else the read seems to return immediately)
read -p "Click on Install Guest Additions... from the Devices menu, then press enter to continue. It may auto mount, in that case the mount command is expected to fail." dummy

mount /media/cdrom
last_invalid

sudo sh /media/cdrom/VBoxLinuxAdditions.run
last_invalid

echo "Setup done. Remember to reboot."

