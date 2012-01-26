PATH=~/Applications:/opt/local/bin:$PATH

# alias for quickly listing a directory
alias ll='ls -al -G'

# alias for quick DNS cache flushing
alias fc='sudo dscacheutil -flushcache'

# alias for getting the machine's ip address into the clipboard
alias getip="ipconfig getpacket en0 | grep -oPe '(?<=yiaddr\s=\s)[\d\.]+' | pbcopy"

# alias for searching SVN projects
# bah! gotta make this a script instead
# alias sslamp="curl -# http://192.168.1.102/projects | grep -oP '(?<=>)?`$1`(?:.+)?(?=<)'"

# alias for quickly editing hosts file
alias ho='bbedit /etc/hosts'
alias vho='bbedit /opt/local/apache2/conf/extra/httpd-vhosts.conf'

# alias for un/loading MAMP
alias mamp="sudo port load apache2"
alias un_mamp="sudo port unload apache2"

# alias for svn to use colorsvn
alias svn='colorsvn'

# alias for common git commands
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gco='git checkout'
alias grH='git reset --hard'
alias gcf='git checkout -- '
alias gc='git commit'
alias glp='git log --graph --pretty=format:"The author of %h was %an, %ar, and they said \"%s\""'

# enable the git bash completion commands
source ~/.git-completion

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

# return the prompt prefix for the second line
function set_prefix {
	BRANCH=`__git_ps1`
	if [[ -z $BRANCH ]]; then
		echo "${NORMAL}o"
	else
		echo "${UNDERLINE}+"
	fi
}

PS1='${MAGENTA}\u${WHITE} in ${GREEN}\w${WHITE}${BLUE}`__git_ps1 " on %s"`${NORMAL}\r\n`set_prefix`${RESET} ${YELLOW}\033[s\033[60C (`date "+%a, %b, %d"`)\033[u${WHITE}' 


#
# e (escape)
# [ (open square bracket)
# ? (question mark)
# 7 (seven)
# l (el - lowercase L)
# c (tells echo to suppress the newline; this is optional)
#
#echo -e "e[?7lc"
