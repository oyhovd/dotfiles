#install zephyr dependencies as listed on web page.. See zephyr home page for details.
sudo apt-get install -y --no-install-recommends git cmake ninja-build gperf \
  ccache doxygen dfu-util device-tree-compiler \
  python3-ply python3-pip python3-setuptools xz-utils file


#additional dependencies for zephyr projects
sudo apt-get install -y libncurses5-dev

#for nrfconnect
sudo apt-get install -y libgconf2-dev libcanberra-gtk-module

#other stuff
sudo apt-get install -y gcc-arm-none-eabi gcc-multilib libcmocka-dev:i386
pip install nrfutil

echo "Make sure to run \"pip3 install --user -r scripts/requirements.txt\" in the zephyr folder"
