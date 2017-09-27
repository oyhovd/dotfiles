alias msbuild="nice -n19 MSBuild.exe"
alias msb="nice -n19 MSBuild.exe"

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
alias gdc="git diff --cached"
alias gl="git log --graph --decorate"
alias glogallnames="git for-each-ref --sort=-committerdate  --format='%(committername) %(committerdate)   %(refname)' refs/remotes/origin"
alias gl1="git log -n1 --decorate"
alias glname="git log --name-status"
alias gco="git checkout"
alias gf="git fetch"
alias gnuke="git clean -xdf"
alias cs=cygstart
alias ninja="nice -n19 ninja"
#alias kill="taskkill -f -im"
#alias python='/cygdrive/c/Python34/python.exe'
alias upfapp='py -2 stack/projects/upfapp/python/console.py'
alias setenv='source setenv'
alias setoyhoenv='source setoyhoenv'
alias setrig='source setrig'

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

