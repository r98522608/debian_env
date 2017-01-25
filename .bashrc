# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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
    xterm-color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
#alias l='ls -CF'
#alias python="python3"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

alias rg="gksu -u ives google-chrome"


mkcd(){
	mkdir -p $1 &&
	cd $1
}

libertySSH(){
	if [ -z "$2" ];then
		sshpass -p foxconn ssh root@10.250.211.$1
	else
		sshpass -p "$2" ssh root@10.250.211.$1
	fi
}

dailyupdate(){
	sudo apt-get update &&
		sudo apt-get dist-upgrade

}

lnvim(){
	if [ "$1" == "c" ]; then
		ln -f  /home/ives/.vimrc_c /home/ives/.vimrc
	else
		ln -f  /home/ives/.vimrc_python /home/ives/.vimrc
	fi
}

mythunder_bird(){
	if [ "$1" == "recv" ]; then
		sudo python3 /home/ives/mail_backup/SuckNotes1.10/sucknotes.py -u ives.yf.chen@mail.foxconn.com -p Aa123456 -e /home/ives/mail_backup
	else
		sudo /usr/thunderbird/thunderbird
	fi
}

connect_mydesktop(){
	 rdesktop -u "gp_kirona@hotmail.com" -g 2560x1440 59.120.61.45
 
}

openstack_local(){
	sshpass -p foxconn ssh root@203.0.113.$1
}

lhcdc(){
	if [ "$1" == "win" ]; then
		rdesktop -u chen -g 1920x980 -p Foxconn123 10.191.174.9
	elif [ -z "$1" ];then
		sshpass -p foxconn ssh root@10.191.174.8
	else
		sshpass -p foxconn ssh root@10.191.174.$1
	fi
}

dora(){
	if [ "$1" == "od" ]; then
		sshpass -p Odoouser1234 ssh elsie@13.76.172.140
	elif [ "$1" == "pr" ]; then
		sshpass -p Prestashop123 ssh pt@13.76.243.63
	elif [ "$1" == "prdb" ]; then
		mysql -u root -p -h 13.76.243.63
	elif [ "$1" == "elk" ]; then
		sshpass -p elk ssh root@52.163.208.160
		#sshpass -p Kibanalog1234 ssh elk@52.187.64.170
	elif [ "$1" == "new_od" ]; then
		ssh -i /home/ives/.ssh/my-ssh-key iivveess@104.199.211.49
	elif [ "$1" == "gluu" ]; then
		sshpass -p Gluuserver123 ssh gluu@23.97.51.141
	fi
}

cit(){
	sshpass -p foxconn ssh root@$1
}


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:/usr/bin/python:/usr/bin/python3:$PATH"
### test

cit(){
	sshpass -p foxconn ssh root@$1
}


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:/usr/bin/python:/usr/bin/python3:$PATH"
### test
