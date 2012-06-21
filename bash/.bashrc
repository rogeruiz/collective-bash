
PATH=~/Applications:/opt/local/bin:$PATH

# alias for quickly listing a directory
alias l='ls -GF'

# alias for quickly listing a directory
alias ll='ls -al -GF'

# alias for going back a directory
alias ..='cd ..'

# alias for going back two directory
alias ...='cd ../..'

# alias for quick DNS cache flushing
alias fc='sudo dscacheutil -flushcache'

# alias for getting the machine's ip address into the clipboard
# alias getip="ipconfig getpacket en0 | grep -oPe '(?<=yiaddr\s=\s)[\d\.]+' | pbcopy"

# alias for searching SVN projects
# bah! gotta make this a script instead
# alias sslamp="curl -# http://192.168.1.102/projects | grep -oP '(?<=>)?`$1`(?:.+)?(?=<)'"

# alias for quickly editing hosts file
alias ho='bbedit /etc/hosts'
alias vho='bbedit /opt/local/apache2/conf/extra/httpd-vhosts.conf'

# alias for un/loading MAMP
alias mamp="sudo port load apache2"
alias un_mamp="sudo port unload apache2"

# enable the git bash completion commands
if [ -f ~/.git-completion ]; then
  source ~/.git-completion
fi

# Bash Completion for SVN
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi


# enable the git unstaged indicators - set to a non-empty value
GIT_PS1_SHOWDIRTYSTATE="."

# enable showing of untracked files - set to a non-empty value
GIT_PS1_SHOWUNTRACKEDFILES="."

# enable stash checking - set to a non-empty value
GIT_PS1_SHOWSTASHSTATE="."

# enable showing of HEAD vs its upstream
GIT_PS1_SHOWUPSTREAM="auto"

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput setaf bold)
NORMAL=$(tput setaf 7)
UNDERLINE=$(tput sgr 0 1)
RESET=$(tput sgr0)


# set prompt to show current working directory and git branch name, if it exists

# this prompt is a green username, black @ symbol, cyan host, magenta current working directory, and white git branch (only shows if you're in a git branch)
# unstaged and untracked symbols are shown, too (see above)
# this prompt uses the short color codes defined above
# PS1='${GREEN}\u${BLACK}@${CYAN}\h:${MAGENTA}\w${WHITE}`__git_ps1 " (%s)"`\$ '


# original one is on top
PS1='${YELLOW}(`date "+%a, %b, %d"`) ${RESET}${MAGENTA}\u${RESET} in ${GREEN}\w${RESET}${BLUE}`__git_ps1 " on %s"`${RESET}\r\n$ '

