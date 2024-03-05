# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History Settings
HISTCONTROL=ignoreboth
HISTSIZE=2000
HISTFILESIZE=2000
export HISTTIMEFORMAT="%d/%m/%y %T "

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    prompt_color='\[\033[1;34m\]'
    path_color='\[\033[1;32m\]'
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
	prompt_color='\[\031[1;31m\]'
	path_color='\[\033[1;34m\]'
    fi
    #PS1='${debian_chroot:+($debian_chroot)}'$prompt_color'\u💀️\h\[\033[00m\]:'$path_color'\w\[\033[00m\]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}💀️'
    #PS1='$'
  
    #CURRENT PROMPT:
    PS1='\[\033[1;34m\]$\[\033[00m\]'

    unset prompt_color path_color
else
    PS1='${debian_chroot:+($debian_chroot)}\uFFF\h:\w\$ '
    #PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[1;31m\]\u💀\h\[\033[00m\]:\[\033[1;32m\]\w\[\033[00m\]\$"
fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[1;31m\]\u💀\h\[\033[00m\]:\[\033[1;32m\]\w\[\033[00m\]\$"
    
    ;;
*)
    ;;
esac

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# alias area
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -lthsF --group-directories-first'
alias v='lvim'
alias 2pt='trans {=pt} -b'
alias rl='rlwrap nc -nlvp 444'
alias catcopy='xclip -sel clip <'
alias x='xdg-open'
alias portas='ss -tupanl || netstat -tupanl'
alias json='jq .'
alias sharkwrite='tshark -w shark.pcap -F pcap -i'
alias sharkread='tshark --color -nr shark.pcap'
alias sharkverbose='tshark --color -nr shark.pcap -V -Y'
alias sharkstream='tshark -q -r shark.pcap -z follow,tcp,ascii,0'
alias sharkhelp='rg shark ~/.bashrc'
alias cd..='cd ..;pwd;ls'
alias sss='ss -latunp'
alias spawn='cat /usr/local/bin/tty.list'
alias militaryabc='json /home/kali/pentest/f-types-pentest/militaryabc'
alias errorcodes='json /home/kali/pentest/f-types-pentest/errorcodes'
alias grepip="grep -oP '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'"
alias grepurl="grep -oP '\bhttps?://\S+'"
alias grepmail="grep -E -o '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'"
alias nohttp="sed 's/^http:\/\///;s/^https:\/\///' "
alias tux57="cd ~/.tux57/ ; figlet 'TuX - 57' ; pwd ; tree -a"
alias ghoststatus='sudo /etc/init.d/tor start 1>/dev/null && echo -e "\033[31m$(curl -s ifconfig.me)\033[0m" && (echo -e "\033[32m$(proxychains -q curl -s ifconfig.me) \033[0m" || echo -e "\033[33mAlgo deu errado\033[0m")'
alias ghoststart='sudo /etc/init.d/tor stop 1>/dev/null && sudo /etc/init.d/tor start 1>/dev/null && echo -e "\033[31m$(curl -s ifconfig.me)\033[0m" && (echo -e "\033[32m$(proxychains -q curl -s ifconfig.me) \033[0m" || echo -e "\033[33mAlgo deu errado\033[0m")'

# personal alias
alias key='kpcli --kdb ~/.tux57/.shadow'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.:
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# My functions

#Find NUCLEI templates for techs and vulns
templatenuclei() {
    grep -REil $1 /home/kali/.local/nuclei-templates/* | egrep ".yaml|.yml|.json" > nuclei.1.tmp
}

# Fancy logs
git() {
    if [[ $@ == "logs" ]]; then
        command git log --all --oneline --graph

    elif [ "$1" == "commit" ] && [ "$2" == "-m" ]; then
        shift  # Remove o 'commit'
        shift  # Remove o '-m'
        mensagem="$@"  # Pega o restante dos argumentos como a mensagem de commit
        command git commit -m "$mensagem"

    else
        command git $@
    fi
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

EDITOR=/usr/bin/vim


# Include PATHs
# Lunar vim
export PATH="$HOME/.local/bin":$PATH

# Go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin


