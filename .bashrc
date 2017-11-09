###########################################################
#cygwin stuff, Nordic specific
if [ -f "$HOME/.is_cygwin" ]; then
  if [ -f "$HOME/.is_nordic" ]; then

    #DITA/Ted for Nordic (cygwin only)
    alias gdita="fig -t dita -t ditamap"
    alias ted="ted.bat"

    #MSBuild for Nordic (cygwin only)
    alias msbuild="nice -n19 MSBuild.exe"
    alias msb="nice -n19 MSBuild.exe"

    fi
fi

###########################################################
#cygwin stuff, general
if [ -f "$HOME/.is_cygwin" ]; then

  alias cs=cygstart

  export PATH="$HOME/scripts:$PATH"
  export PATH="$HOME/devel/g:/cygdrive/c/tedtools/ted:$PATH"
  export PATH="$HOME/devel/fig:$PATH"
  export PATH="$HOME/devel/f:$PATH"

  #for MinGW
  export PATH="/cygdrive/c/MinGW/bin:/cygdrive/c/Program Files (x86)/cmocka/bin:/cygdrive/c/Program Files/7-Zip:$PATH"

  #adding cygwin last in case we use MinGW and want to access the cygwin tools
  export PATH="$PATH:/c/cygwin64/bin"

  #override this on cygwin
  export TESTHARNESSPY="/bin/python"

  #cygwin python
  alias cygpy="/cygdrive/c/cygwin64/bin/python"

fi

###########################################################
#Debian stuff, Nordic related
if ! [ -f "$HOME/.is_cygwin" ]; then
  if [ -f "$HOME/.is_nordic" ]; then

    #Keil/MDK stuff
    export KEIL_PATH=/home/oyho/armstuff
    export FAMILY_PACK_PATH=/home/oyho/armstuff/ARM/Pack/NordicSemiconductor/nRF_DeviceFamilyPack/8.14.1.ext/Device
    export CMSIS_PATH=/home/oyho/armstuff/ARM/Pack/ARM/CMSIS/4.1.0/CMSIS

    #ARM Compiler 5 stuff
    export PATH="/usr/local/ARM_Compiler_5.06u4/bin:$PATH"
    export PATH="/usr/local/gcc-arm-none-eabi-5_4-2016q3/bin/:$PATH"
    export ARMLMD_LICENSE_FILE=1714@licsrv1.nvlsi.no
    export ARM_TOOL_VARIANT=mdk_pro_flex

    #flash script
    alias flash="$HOME/devel/debug-tools/flash"

    alias gdb="gdb-multiarch"
    alias jira="temp=/home/oyho/devel/jira_cmd python3 ~/devel/jira_cmd/jira.py"

    export CTEST_OUTPUT_ON_FAILURE=1                     # You don't have to set --output-on-failure everytime you call ctest.
    export CMOCKA_MESSAGE_OUTPUT=STDOUT #|SUBUNIT|TAP|XML  # Determines the output format of cmocka.
    export CMOCKA_XML_FILE='./test-report.xml'           # Get the XML test report into the file test-report.xml

    export CC='/usr/bin/gcc-6' #unit tests set up for ggc-4 really, but 6 works. 7 throws warnings.

    #don't remember what this is for
    export PATH="$PATH:$HOME/.local/bin"

  fi
fi

###########################################################
#Debian stuff, general
#turn off nagging for password (turn of energy star)
xset -dpms > /dev/null 2>&1

###########################################################
#Nordic stuff, platform independent
if [ -f "$HOME/.is_nordic" ]; then
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

  export VisualStudioDisabled='true'

  export PATH="$HOME/devel/debug-tools:$PATH"

fi

##########################
#zephyr-stuff
source $HOME/devel/zephyr/zephyr-env.sh > /dev/null 2>&1

###########################################################
#General stuff, platform independent

#hack to force terminal to UTF-8, see http://www.cl.cam.ac.uk/~mgk25/unicode.html#term
#print -n '\e%G'

#some fixes for git
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#ninja with nice
alias ninja="nice -n19 ninja"

#show all git branches with last commiter
alias glogallnames="git for-each-ref --sort=-committerdate  --format='%(committername) %(committerdate)   %(refname)' refs/remotes/origin"

alias gl="git log --graph --decorate"
alias gl1="git log -n1 --decorate"
# Exclude all files in nuke-exclude from gnuke
alias gnuke="git clean -xdf $(for line in `cat $HOME/dotfiles/gnuke-exclude`; do echo -n "--exclude=\"$line\" "; done)"

alias gchs='grep -r --include "*.[chsS]"'

alias j='jobs'

#adding private bin for overloading tools etc
export PATH="$HOME/bin:$PATH"

#default editor for fc command
export FCEDIT=vim
