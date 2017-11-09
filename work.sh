#install zephyr dependencies as listed on web page.. See zephyr home page for details.
sudo apt-get install --no-install-recommends git cmake ninja-build gperf \
  ccache doxygen dfu-util device-tree-compiler \
  python3-ply python3-pip python3-setuptools xz-utils file


#additional dependencies for zephyr projects
sudo apt-get install libncurses5-dev

echo "Make sure to run \"pip3 install --user -r scripts/requirements.txt\" in the zephyr folder"
