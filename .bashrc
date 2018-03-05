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

git_branch(){
# this function is for $PS1 command line
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git:\1)/'
}

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #old one
#	PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[00m\]:\[\033[01;34m\]${PWD#"${PWD%/*/*}/"}\[\033[00m\]]\[\033[01;32m\]$(git_branch)\[\033[00m\]\[\033[0;35m\]-->\[\033[00m\] '
	PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[00m\]:\[\033[01;34m\]${PWD#"${PWD%/*/*}/"}\[\033[00m\] #\#]\[\033[01;32m\]$(git_branch)\[\033[00m\]\[\033[0;35m\]-->\[\033[00m\] '
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

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias ww=welcome_msg
#alias l='ls -CF'
alias python="python2.7"

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

###
fn="/home/ives/.ives/todo.txt"
index=1
while read LINE
do
mylist[$index]=$LINE
index=$((index+1))
done <$fn

fn="/home/ives/.ives/dir.txt"
index=1
while read LINE
do
mydir[$index]=$LINE
index=$((index+1))
done <$fn

###

mkcd(){
	mkdir -p $1 &&
	cd $1
}

dailyupdate(){
	sudo apt-get update -y &&
		sudo apt-get dist-upgrade -y

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
		rdesktop -u chen -g 2460x980 -p Foxconn123 10.191.174.9
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
	fi
}

cit(){
	sshpass -p foxconn ssh root@$1
}

bbs(){
	 luit -encoding big5 telnet $1
}

tmp(){
	ipmitool -I lan -H 10.212.146.x -U admin -P admin raw 0x06 0x02
}

ives_scan_networking(){
	nmap -v -p 443 --script ssl-heartbleed 10.57.241.0/24
}
mykali(){
	sshpass -p kaa52025 ssh root@192.168.56.102
}
gojump(){
	if [ "$1" == "0" ];then
		sshpass -p foxconn ssh root@10.212.146.92
	else
		sshpass -p foxconn ssh root@10.212.146.65
	fi

}
golinux(){
	cd /lib/modules/$(uname -r)/build/ives_mod
}
zombie_find(){
	ps aux | awk '"[Zz]" ~ $8 { printf("%s, PID = %d\n", $8, $2); }'
}

ives_md5(){
	hash="$(echo -n "$1" | md5sum )"
	echo "$hash"
}
local_stack(){
	if [ "$1" == "1" ]; then
                sshpass -p foxconn ssh root@10.0.0.35
	elif [ "$1" == "2" ]; then
                sshpass -p foxconn ssh root@10.0.0.103
	elif [ "$1" == "3" ]; then
                sshpass -p foxconn ssh root@10.0.0.105
	elif [ "$1" == "4" ]; then
                sshpass -p foxconn ssh root@10.0.0.132
	elif [ "$1" == "5" ]; then
                sshpass -p foxconn ssh root@10.0.0.251
	elif [ "$1" == "win" ]; then
		rdesktop -u "ives" -g 1920x1080 10.0.0.66
#		rdesktop -u "ives" -g 2560x1440 10.0.0.66
        else
                sshpass -p foxconn ssh root@10.0.0.35
        fi
}



### Added by the Heroku Toolbelt
export PATH="/home/ives/extra_vol/remote_repo:/usr/local/heroku/bin:/usr/bin/python:/usr/bin/python3:$PATH"
CSCOPE_DB="/home/ives/code/cloud-init/cscope.out"
welcome_msg(){
echo -e "#   \033[01;32m _ _\033[00m"
echo -e "#   \033[01;32m(_|_)_   ____   _____  ___  ___ ___\033[00m"
echo -e "#   \033[01;32m| | \\ \\ / /\\ \\ / / _ \\/ _ \\/ __/ __|\033[00m"
echo -e "#   \033[01;32m| | |\\ V /  \\ V /  __/  __/\\__ \\__ \\ \033[00m"
echo -e "#   \033[01;32m|_|_| \\_/    \\_/ \\___|\\___||___/___/\033[00m"
echo -e "#"

echo "  -------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e " /	Welcome to \033[01;32m${USER}'s shell ! \033[00m, now in \033[01;36m$(pwd)\033[00m				"
echo -e "| 	Currently in \033[01;35mtodo list\033[00m:								"
for i in ${!mylist[@]}
do
echo -e "| 		$i: \033[04;95m${mylist[i]}\033[00m"
done
echo -e "| 	Fast \033[01;35mdirectories\033[00m:								"
for i in ${!mydir[@]}
do
echo -e "| 		$i: \033[04;95m${mydir[i]}\033[00m"
done
echo -e " \ 	"
echo "  -------------------------------------------------------------------------------------------------------------------------------------------------"
}

icd(){
			
		if [[ -v ${mydir} ]]; then 
				#echo "var is unset"
				fn="/home/ives/.ives/dir.txt"
				index=1
				while read LINE
				do
				mydir[$index]=$LINE
				index=$((index+1))
				done <$fn

	   	#else 
				#echo "var is set "
	   	fi
		#if [[ -v ${mydir[1]} ]]; then echo "var is unset"; else echo "var is set to '$var'"; fi
		cd ${mydir[$1]}
}

#welcome_msg
if [ "$(id -u)" == "0" ]; then
	welcome_msg
	route -n
	else
	welcome_msg

fi

eval $(thefuck --alias)



##################################
#export PROMPT_COMMAND=__prompt_command      # Func to gen PS1 after CMDs

function __prompt_command() {
	local EXIT="$?"                         # This needs to be first
	welcome_msg
	PS1=""

	### Colors to Vars ### {{{
	## Inspired by http://wiki.archlinux.org/index.php/Color_Bash_Prompt#List_of_colors_for_prompt_and_Bash
	## Terminal Control Escape Sequences: http://www.termsys.demon.co.uk/vtansi.htm
	## Consider using some of: https://gist.github.com/bcap/5682077#file-terminal-control-sh
	## Can unset with `unset -v {,B,U,I,BI,On_,On_I}{Bla,Red,Gre,Yel,Blu,Pur,Cya,Whi} RCol`
	local RCol='\[\e[0m\]'	# Text Reset

	# Regular                    Bold                          Underline                     High Intensity                BoldHigh Intensity             Background                High Intensity Backgrounds
	local Bla='\[\e[0;30m\]';    local BBla='\[\e[1;30m\]';    local UBla='\[\e[4;30m\]';    local IBla='\[\e[0;90m\]';    local BIBla='\[\e[1;90m\]';    local On_Bla='\e[40m';    local On_IBla='\[\e[0;100m\]';
	local Red='\[\e[0;31m\]';    local BRed='\[\e[1;31m\]';    local URed='\[\e[4;31m\]';    local IRed='\[\e[0;91m\]';    local BIRed='\[\e[1;91m\]';    local On_Red='\e[41m';    local On_IRed='\[\e[0;101m\]';
	local Gre='\[\e[0;32m\]';    local BGre='\[\e[1;32m\]';    local UGre='\[\e[4;32m\]';    local IGre='\[\e[0;92m\]';    local BIGre='\[\e[1;92m\]';    local On_Gre='\e[42m';    local On_IGre='\[\e[0;102m\]';
	local Yel='\[\e[0;33m\]';    local BYel='\[\e[1;33m\]';    local UYel='\[\e[4;33m\]';    local IYel='\[\e[0;93m\]';    local BIYel='\[\e[1;93m\]';    local On_Yel='\e[43m';    local On_IYel='\[\e[0;103m\]';
	local Blu='\[\e[0;34m\]';    local BBlu='\[\e[1;34m\]';    local UBlu='\[\e[4;34m\]';    local IBlu='\[\e[0;94m\]';    local BIBlu='\[\e[1;94m\]';    local On_Blu='\e[44m';    local On_IBlu='\[\e[0;104m\]';
	local Pur='\[\e[0;35m\]';    local BPur='\[\e[1;35m\]';    local UPur='\[\e[4;35m\]';    local IPur='\[\e[0;95m\]';    local BIPur='\[\e[1;95m\]';    local On_Pur='\e[45m';    local On_IPur='\[\e[0;105m\]';
	local Cya='\[\e[0;36m\]';    local BCya='\[\e[1;36m\]';    local UCya='\[\e[4;36m\]';    local ICya='\[\e[0;96m\]';    local BICya='\[\e[1;96m\]';    local On_Cya='\e[46m';    local On_ICya='\[\e[0;106m\]';
	local Whi='\[\e[0;37m\]';    local BWhi='\[\e[1;37m\]';    local UWhi='\[\e[4;37m\]';    local IWhi='\[\e[0;97m\]';    local BIWhi='\[\e[1;97m\]';    local On_Whi='\e[47m';    local On_IWhi='\[\e[0;107m\]';
	### End Color Vars ### }}}

	if [ $UID -eq "0" ];then
		PS1+="${Red}\h \W ->${RCol} "       ## Set prompt for root
	  else
		local PSCol=""                      ## Declare so null var fine
		local PSOpt=""                      ## Above, and fixes repeat issue

		if [ $EXIT != 0 ]; then
			## can add `kill -l $?` to test to filter backgrounded
			PS1+="${Red}${EXIT}${RCol}"     ## Add exit code, if non 0
		fi

		### Machine Test ### {{{
		if [ $HOSTNAME == 'moving-computer-of-doom' ]; then
			local PSCol="$Cya"              ## For Main Computer
		elif [ $HOSTNAME == 'vps-of-doom' ]; then
			local PSCol="$Blu"              ## For VPS
		elif [ $HOSTNAME == 'ma.sdf.org' ]; then
			local PSCol="${Yel}"            #@ For MetaArray
			local PSOpt="\h "
		elif [ $HOSTNAME == 'fencepost.gnu.org' ]; then
			local PSCol="${On_Pur}"         ## For Gnu
			local PSOpt="\h "
		elif [ $HOSTTYPE == 'arm' ]; then
			local PSCol="$Gre"              #@ For pi
		elif [[ $MACHTYPE =~ arm-apple-darwin ]]; then
			local PSCol="$Gre"              ## For iOS
		elif [ $MACHTYPE == 'i486-pc-linux-gnu' ]; then
			local PSCol="$BBla"             ## For Netbook
		elif [[ "$MACHTYPE" == "x86_64--netbsd" && "$OSTYPE" == "netbsd" ]]; then
			local PSCol="${Yel}"            ## For Main Cluster
			local PSOpt="\h "
		elif [ "$MACHTYPE" == "mips-openwrt-linux-gnu" ]; then
			local PSCol="${On_Pur}"         ## For OpenWrt
			local PSOpt="\h "
		  else
			local PSCol="${Pur}"            ## Un-designated catch-all
			local PSOpt="\h "
			MISSING_ITEMS+="machine-prompt, "
		fi
		### End Machine Test ### }}}

		PS1+="${PSCol}${PSOpt}\W${RCol}"    ## Current working dir

		### Check Jobs ### {{{
		command jobs 2>/dev/null
		if [ $? == "0" ]; then
			## Backgrounded running jobs
			local BKGJBS=$(jobs -r | wc -l | tr -d ' ')
			if [ ${BKGJBS} -gt 2 ]; then
				PS1+=" ${Red}[bg:${BKGJBS}]${RCol}"
			elif [ ${BKGJBS} -gt 0 ]; then
				PS1+=" ${Yel}[bg:${BKGJBS}]${RCol}"
			fi

			## Stopped Jobs
			local STPJBS=$(jobs -s | wc -l | tr -d ' ')
			if [ ${STPJBS} -gt 2 ]; then
				PS1+=" ${Red}[stp:${STPJBS}]${RCol}"
			elif [ ${STPJBS} -gt 0 ]; then
				PS1+=" ${Yel}[stp:${STPJBS}]${RCol}"
			fi
		fi
		### End Jobs ### }}}

		### Add Git Status ### {{{
		## Inspired by http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/
		if [[ $(command -v git) ]]; then
			local GStat="$(git status --porcelain -b 2>/dev/null | tr '\n' ':')"

			if [ "$GStat" ]; then
				### Fetch Time Check ### {{{
				local LAST=$(stat -c %Y $(git rev-parse --git-dir 2>/dev/null)/FETCH_HEAD 2>/dev/null)
				if [ "${LAST}" ]; then
					local TIME=$(echo $(date +"%s") - ${LAST} | bc)
					## Check if more than 60 minutes since last
					if [ "${TIME}" -gt "3600" ]; then
						git fetch 2>/dev/null
						PS1+=' +'
						## Refresh var
						local GStat="$(git status --porcelain -b 2>/dev/null | tr '\n' ':')"
					fi
				fi
				### End Fetch Check ### }}}

				### Test For Changes ### {{{
				## Change this to test for 'ahead' or 'behind'!
				local GChanges="$(echo ${GStat} | tr ':' '\n' | grep -v "^$" | grep -v "^\#\#" | wc -l | tr -d ' ')"
				if [ "$GChanges" == "0" ]; then
					local GitCol=$Gre
				  else
					local GitCol=$Red
				fi
				### End Test Changes ### }}}

				### Find Branch ### {{{
				local GBra="$(echo ${GStat} | tr ':' '\n' | grep "^##" | cut -c4- | grep -o "^[a-zA-Z]\{1,\}[^\.]")"
				if [ "$GBra" ]; then
					if [ "$GBra" == "master" ]; then
						local GBra="M"      ## Because why waste space
					fi
				  else
					local GBra="ERROR"      ## It could happen supposedly?
				fi
				### End Branch ### }}}

				PS1+=" ${GitCol}[$GBra]${RCol}"	## Add result to prompt

				### Find Commit Status ### {{{
				## Test Modified and Untracked for "0"
				# local GDel="$(echo ${GStat} | tr ':' '\n' | grep -c "^[ MARC]D")"

				local GAhe="$(echo ${GStat} | tr ':' '\n' | grep "^##" | grep -o "ahead [0-9]\{1,\}" | grep -o "[0-9]\{1,\}")"
				if [ "$GAhe" ]; then
					PS1+="${Gre}↑${RCol}${GAhe}"    ## Ahead
				fi

				## Needs a `git fetch`
				local GBeh="$(echo ${GStat} | tr ':' '\n' | grep "^##" | grep -o "behind [0-9]\{1,\}" | grep -o "[0-9]\{1,\}")"
				if [ "$GBeh" ]; then
					PS1+="${Red}↓${RCol}${GBeh}"    ## Behind
				fi

				local GMod="$(echo ${GStat} | tr ':' '\n' | grep -c "^[ MARC]M")"
				if [ "$GMod" -gt "0" ]; then
					PS1+="${Pur}≠${RCol}${GMod}"    ## Modified
				fi

				local GUnt="$(echo ${GStat} | tr ':' '\n' | grep -c "^\?")"
				if [ "$GUnt" -gt "0" ]; then
					PS1+="${Yel}?${RCol}${GUnt}"    ## Untracked
				fi
				### End Commit Status ### }}}
			fi
		  else
			MISSING_ITEMS+="git-prompt, "
		fi
		### End Git Status ### }}}

		PS1+=" ${PSCol}-> ${RCol}"          ## End of PS1
	fi
}
### End PS1 ### }}}

todolist(){
	local item=$1
	local opt=$2
	local msg=$3
	local confirm=$4

	sed '${item}${opt}/\(.*\)/\1 [***]===> ${msg}/' ~/todo.txt
}


