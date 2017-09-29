source $HOME/dotfiles/.zshrc

#alias win="ssh -t 192.168.56.1 'cd `pwd | sed s:/home/oyho/::` ; zsh'"
#just to overload the common bashrc version
alias mbrupdate="/home/oyho/bin/mbrupdate.sh"

#ARM Compiler 5 stuff
#export PATH="/usr/local/ARM_Compiler_5.06u5/bin:$PATH"
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

export PATH="$PATH:$HOME/.local/bin"
