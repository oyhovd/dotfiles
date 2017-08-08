export LOCAL_NRF52_DEV_KIT='682256194'
export LOCAL_NRF51_DEV_KIT='681919129'
alias msbuild="nice -n19 MSBuild.exe"
alias msb="nice -n19 MSBuild.exe"
alias msb51="nice -n19 MSBuild.exe -p:targetplatform=nrf51"
alias msb52="nice -n19 MSBuild.exe -p:targetplatform=52fp1"

fmsb51() {
  msb51 `f $@ build.xml`
}

fmsb52() {
  msb52 `f $@ build.xml`
}

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

alias cfind="/c/cygwin64/bin/find"
alias gitbash="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Git/bin/sh.exe --login -l"
alias gitbrancha="git branch -a"
alias gs="git status"
alias gb="git branch"
alias gba="git branch -a"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log --graph --decorate"
alias glol="git lol"
alias glogallnames="git for-each-ref --sort=-committerdate  --format='%(committername) %(committerdate)   %(refname)' refs/remotes/origin"
alias gl1="git log -n1 --decorate"
alias glname="git log --name-status"
alias gco="git checkout"
alias gf="git fetch"
alias gc="git commit"
alias gnuke="git clean -xdf"
alias gclean="git clean -df"
alias gtestnuke="git clean -xdn"
alias gitresetall="git rm --cached -r . ; git reset --hard"
alias cs=cygstart
alias ninja="nice -n19 ninja"
#alias kill="taskkill -f -im"
#alias python='/cygdrive/c/Python34/python.exe'
alias upfapp='py -2 stack/projects/upfapp/python/console.py'
alias setenv='source setenv'
alias setoyhoenv='source setoyhoenv'
alias setrig='source setrig'

alias devappbuild52=" ninja devapp; ninja softdevice; nrfjprog -s $LOCAL_NRF52_DEV_KIT --family nrf52 -e; nrfjprog -s $LOCAL_NRF52_DEV_KIT --family nrf52 --program stack/projects/softdevice/build/s132.hex ; nrfjprog -s $LOCAL_NRF52_DEV_KIT --family nrf52 --program ./stack/projects/devapp/build/devapp_nrf52.hex; nrfjprog -s $LOCAL_NRF52_DEV_KIT --family nrf52 -r"
alias devappbuild51=" ninja devapp; ninja softdevice; nrfjprog -s $LOCAL_NRF51_DEV_KIT --family nrf51 -e; nrfjprog -s $LOCAL_NRF51_DEV_KIT --family nrf51 --program stack/projects/softdevice/build/s130.hex ; nrfjprog -s $LOCAL_NRF51_DEV_KIT --family nrf51 --program ./stack/projects/devapp/build/devapp_nrf51.hex; nrfjprog -s $LOCAL_NRF51_DEV_KIT --family nrf51 -r"

alias ted="ted.bat"
alias gchs='grep -r --include "*.[chs]"'
#alias gchs="g .[chs]"
alias gdita="fig -t dita -t ditamap"
 #alias gdita="g .dita*"

#alias gitsvnfetch="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Git/bin/sh.exe --login -l"
#alias gitsvnfetch="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Git/bin/sh.exe -l -c \"git svn fetch\""
#alias gitsvnfetch="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Git/bin/sh.exe -c 'exec bash'"

export CTEST_OUTPUT_ON_FAILURE=1                     # You don't have to set --output-on-failure everytime you call ctest.
export CMOCKA_MESSAGE_OUTPUT=STDOUT #|SUBUNIT|TAP|XML  # Determines the output format of cmocka.
export CMOCKA_XML_FILE='./test-report.xml'           # Get the XML test report into the file test-report.xml

#adding private bin for overloading tools etc
export PATH="$HOME/bin:$PATH"

