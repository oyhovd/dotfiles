###########################################################
#DITA/Ted for Nordic (cygwin only)
alias gdita="fig -t dita -t ditamap"
alias ted="ted.bat"

#MSBuild for Nordic (cygwin only)
alias msbuild="nice -n19 MSBuild.exe"
alias msb="nice -n19 MSBuild.exe"

###########################################################
#cygwin stuff, general
alias cs=cygstart

###########################################################
#Debian stuff, Nordic related
#Keil/MDK stuff
export KEIL_PATH=/home/oyho/armstuff
export FAMILY_PACK_PATH=/home/oyho/armstuff/ARM/Pack/NordicSemiconductor/nRF_DeviceFamilyPack/8.9.0/Device
export CMSIS_PATH=/home/oyho/armstuff/ARM/Pack/ARM/CMSIS/4.1.0/CMSIS

#ARM Compiler 5 stuff
export PATH="/usr/local/ARM_Compiler_5.06u4/bin:$PATH"
export PATH="/usr/local/gcc-arm-none-eabi-5_4-2016q3/bin/:$PATH"
export ARMLMD_LICENSE_FILE=1714@licsrv1.nvlsi.no
export ARM_TOOL_VARIANT=mdk_pro_flex

#flash script
alias flash="/home/oyho/devel/debug-tools/flash"

alias gdb="gdb-multiarch"
alias jira="temp=/home/oyho/devel/jira_cmd python3 ~/devel/jira_cmd/jira.py"

export CTEST_OUTPUT_ON_FAILURE=1                     # You don't have to set --output-on-failure everytime you call ctest.
export CMOCKA_MESSAGE_OUTPUT=STDOUT #|SUBUNIT|TAP|XML  # Determines the output format of cmocka.
export CMOCKA_XML_FILE='./test-report.xml'           # Get the XML test report into the file test-report.xml

#don't remember what this is for
export PATH="$PATH:$HOME/.local/bin"

###########################################################
#Debian stuff, general
#turn off nagging for password (turn of energy star)
xset -dpms > /dev/null 2>&1

###########################################################
#Nordic stuff, platform independent

export TESTHARNESSPY="python"
function remotetestharness {
  find . -name "$2" -exec $TESTHARNESSPY ~/devel/test_harness/test_harness.py test --tests {}/build.xml -m"-t:compile,test ${@:3}" --ellisys -t $1 \; -quit
  ls tmp_*.zip -t | head -1 | xargs -I {} 7z x -y {} console_output.txt captures -r
}
# python ~/devel/test_harness/test_harness.py test --tests ./nrfsoc/test/tp_rob_rem_003/build.xml -m"-t:compile,test " --ellisys -c -t rf-test

function vikartest {
  remotetestharness vikar1.nvlsi.no $1 ${@:2}
}

function vikartest52 {
  vikartest $1 "-p:targetplatform=52fp1 ${@:2}"
}

function vikartest51 {
  vikartest $1 "-p:targetplatform=nrf51 ${@:2}"
}

function rftest {
  remotetestharness rf-test.nvlsi.no $1 ${@:2}
}

function rftest52 {
  rftest $1 "-p:targetplatform=52fp1 ${@:2}"
}

function rftest51 {
  rftest $1 "-p:targetplatform=nrf51 ${@:2}"
}

export CTEST_OUTPUT_ON_FAILURE=1                     # You don't have to set --output-on-failure everytime you call ctest.
export CMOCKA_MESSAGE_OUTPUT=STDOUT #|SUBUNIT|TAP|XML  # Determines the output format of cmocka.
export CMOCKA_XML_FILE='./test-report.xml'           # Get the XML test report into the file test-report.xml

#zephyr-stuff
export ZEPHYR_BASE="$HOME/devel/zephyr"
export ZEPHYR_SDK_INSTALL_DIR="$HOME/opt/zephyr-sdk"
export ZEPHYR_GCC_VARIANT=zephyr
source $HOME/devel/zephyr/zephyr-env.sh > /dev/null 2>&1

function cpatch()
{
  echo $1
  find $1 -type f -exec ~/devel/zephyr/scripts/checkpatch.pl -f {} \;
}

function fnit()
{
  echo $1
  echo $1zephyr.hex
  pyocd-flashtool -d debug -t nrf52 -ce && pyocd-flashtool -d debug -t nrf52 $1zephyr.hex
}

function fdk52()
{
  echo $1
  echo $1zephyr.hex
  nrfjprog --eraseall -f nrf52 && nrfjprog --program $1zephyr.hex -f nrf52 && nrfjprog -r -f nrf52
}

function fdk51()
{
  echo $1
  echo $1zephyr.hex
  nrfjprog --eraseall -f nrf51 && nrfjprog --program $1zephyr.hex -f nrf51 && nrfjprog -r -f nrf51
}

function dbg52()
{

  JLinkGDBServer -device nrf52 -if swd -speed 4000 &
  /home/carles/prog/zephyr-sdk/sysroots/i686-pokysdk-linux/usr/bin/arm-poky-eabi/arm-poky-eabi-gdb
}

###########################################################
#General stuff, platform independent

#ninja with nice
alias ninja="nice -n19 ninja"

#show all git branches with last commiter
alias glogallnames="git for-each-ref --sort=-committerdate  --format='%(committername) %(committerdate)   %(refname)' refs/remotes/origin"

alias gl1="git log -n1 --decorate"
alias gnuke="git clean -xdf"

alias gchs='grep -r --include "*.[chsS]"'

#adding private bin for overloading tools etc
export PATH="$HOME/bin:$PATH"

#default editor for fc command
export FCEDIT=vim
