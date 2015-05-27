# ~/.zshrc
# Maintainer: Issac Sharp
##########################
export TERM=rxvt-unicode
export EDITOR=vim
autoload -U promptinit
promptinit

export RPROMPT="<-%t"  
export PROMPT=$'%{\e[0m%}%n %{\e[0m%}%~ %{\e[31m%}$ %{\e[0m%}'

stty erase '^?'

# Apply my colors if running zsh on a bare tty
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000"
    echo -en "\e]P8808080"
    echo -en "\e]P1FF9F95" #red
    echo -en "\e]P9FF8D80" #darkred
    echo -en "\e]P2E2FFC7" #green
    echo -en "\e]PAD8FFB3" #darkgreen
    echo -en "\e]P3FFFFB9" #brown
    echo -en "\e]PBFFBE64" #yellow
    echo -en "\e]P4A8CEFA" #darkblue
    echo -en "\e]PC7EB6FF" #blue
    echo -en "\e]P5E2B5CC" #darkmagenta
    echo -en "\e]PDE296FF" #magenta
    echo -en "\e]P6C2EFFF" #darkcyan
    echo -en "\e]PE9CE9FF" #cyan
    echo -en "\e]P7dddddd" #lightgrey
    echo -en "\e]PFffffff" #white
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Start in ~
cd /home/ifs

export PATH=$PATH:/usr/local/go/bin:/home/ifs/scripts
export PATH=$PATH:/home/ifs/bin/idea/idea-IC-139.659.2/bin
export PATH=$PATH:/home/ifs/bin
export PATH=/opt/texbin:$PATH
export GOROOT=/usr/local/go


# Some shell functions
unpack () 
{
  if [ -f "$1" ] ; then
      case "$1" in
          *.tar.bz2) tar xvjf "$1" ;;
          *.tar.gz) tar xvzf "$1" ;;
          *.bz2) bunzip2 "$1" ;;
          *.rar) rar x "$1" ;;
          *.gz) gunzip "$1" ;;
          *.tar) tar xvf "$1" ;;
          *.tbz2) tar xvjf "$1" ;;
          *.tgz) tar xvzf "$1" ;;
          *.zip) unzip "$1" ;;
          *.Z) uncompress "$1" ;;
          *.7z) 7z x "$1" ;;
          *) echo "don't know how to extract "$1"..." ;;
      esac
  else
      echo ""$1" is not a valid file!"
  fi
}

stfu()
{
	("$@" 1>/dev/null 2>/dev/null &)
}

dict()
{
		command dict "$@" | less
}

vpn()
{
	if  ((systemctl status openvpn.service) | grep --quiet inactive)
	then
		echo "starting. . . .\n"
		sudo systemctl start openvpn.service
	else
		echo "stopping. . . .\n"
		sudo systemctl stop openvpn.service
	fi
	systemctl status openvpn.service
}

# Calculate on command line
mm()
{
	echo "$@" | bc
}

# Filter to get specific column of output
function awks
{
	first="awk '{print "
	last="}'"
	cmd="${first}\$${1}${last}"
eval $cmd
}

# Record animated gif
function byz {
	byzanz-record -d $1 $2 2>/dev/null;
	notify-send finished.
}

# Store current working directory's name for recall
function cdd
{
	echo `pwd` > ~/.last_dir
}
alias cdr='cd `cat ~/.last_dir`'

# "Sharp" find, and "Sharp" find content
function sf() {find . -iname "*$1*"; }
alias sfc='find . -print0 | xargs -0 grep --directories=skip -l'

#### ALIASES ####
#File management/general

alias fuck='sudo $(fc -ln -1)'
alias btsync="btsync --config /home/ifs/.btsync.rc"
alias x="exit"
alias vimsh='vim ~/.zshrc'
alias fetch='echo "\n" && fetch && echo "\n"'
alias nort="mupdf /home/ifs/books/Norton_Anthology_of_Poetry.pdf &"
alias sc='systemctl'
alias ut='sudo nmcli con up id ut-wpa2'
alias sysinfo='perl /usr/bin/sysinfo281.21.pl'

alias war='nmcli con up id The\ Warroom'
alias pat='nmcli con up id Patrick\ Stewart'
alias ranger='ranger 2> /dev/null'
alias screenfetch="echo '\n'  && /usr/bin/screenfetch -o 'mygtk2=FlintStudio;mygtk=FlintStudio'"

alias free="zsh ~/scripts/free.sh; free"
alias mail='getmail --rcfile getmailrc1 --rcfile getmailrc2'
alias toi='toilet -t -f mono12'
alias c='clear'
alias ls='ls --color=always --group-directories-first'
alias ll='ls -l'
alias la='ll -A'
alias rm='rm'
alias rms='srm'
alias mv='mv'
alias mkdir='mkdir -p'
alias toff='sudo su -c "shutdown -h -P now"'
alias trip='cat /home/ifs/beet | xclip'
alias clock="tty-clock -t"

# Shortcuts for stfu() programs
alias gimp="stfu gimp"
alias keep="stfu keepassx"
alias feh="stfu feh"

# Bookmarked directories
alias dev1="cd ~/prog/sandbox/collatz"
alias dev2="cd ~/prog/sandbox/c/structures"

# Battery info
function bat {
    now=`cat /sys/class/power_supply/BAT0/energy_now`
    full=`cat /sys/class/power_supply/BAT0/energy_full`
    out=`echo "$now/$full*100" | bc -l | cut -c 1-5`
    echo Charge: "$out"%""
}

# List drive devices, with info
alias drives='sudo blkid -o list -c /dev/null'

# Unmount a drive
alias um='sudo sync; sudo umount'

# Colorize gcc
export GTK_RC_FILES="/home/ifs/.themes/Siva\ Flat/gtk-2.0/gtkrc"

# Java runtime path
export JAVA_HOME="/opt/java/jre1.7.0_51/bin/java"

# Fix tmux colors
alias tmux="tmux -2"

# Fake a C interpreter on the command-line
go_libs="-lm"
go_flags="-g -Wall -I -O0"
alias go_c="c99 -xc '-' $go_libs $go_flags"

# List the wait queue for status D (uninterruptible sleep) processes
alias statusD="sudo ps axopid,comm,wchan"

# Edit apt mirrors
alias src='sudo vim /etc/apt/sources.list'

# Archival and Compression
alias ctbz2='tar -jcvf'
alias ctgz='tar -zcvf'
alias tgz="tar -xvzf"
alias tbz2="tar -xvjf"
alias txz="tar -xJf"

# Program Shortcuts
alias sch="mupdf ~/notes/fall2014.pdf"
alias armory="nohup /usr/lib/armory/ArmoryQt.py &"
alias sysd="sudo systemctl"
alias suap="sudo aptitude"
alias enc="gpg --cipher-algo AES256 --symmetric --sign --force-mdc"
alias mus="ncmpcpp"
alias music="ncmpcpp"
alias wee="weechat-curses"
alias tasc="task && echo '\n' && cal"
alias scanloc='nmap -sn 192.168.1.1/24'
alias taskwk='task due.before:saturday'
alias taskcal='task calendar'
alias speedtest="speedtest_cli.py"
alias viz='mpdviz -v spectrum  -i color=false'
alias cpr="sudo rsync -proghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias vew='vi `\ls -t * | head -1 `'

######## Keybinding ########
set -o vi
zle-keymap-select () {

	if [ $TERM = "rxvt-unicode-256color" ]; then
		if [ $KEYMAP = vicmd ]; then
			if [[ $TMUX = '' ]]; then
				echo -ne "\033]12;#6699CC\007"
			else
				echo "\033Ptmux;\033\033]12;blue\007\033\\"
			fi
		else
			if [[ $TMUX = '' ]]; then
				echo -ne "\033]12;grey\007"
			else
				echo "\033Ptmux;\033\033]12;grey\007\033\\"
			fi
		fi
	fi
}

zle-line-init () {
	zle -K viins
	if [ $TERM = "rxvt-unicode-256color" ]; then
		echo -ne "\033]12;grey\007"
	fi
}
zle -N zle-keymap-select
zle -N zle-line-init
############################

export HISTFILE=~/.histfile
export HISTSIZE=10000
export SAVEHIST=10000
setopt autocd extendedglob
bindkey -v
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'g~' vi-oper-swap-case
bindkey -a G end-of-buffer-or-history
bindkey -a u undo
bindkey -a '^R' redo
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[7~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey '^[[2~' overwrite-mode

# Enable custom "dircolors" in listings
eval "$(dircolors ~/.dirname)";

# Disable terminal control flow
stty -ixon

# Shell command tab-completion
fpath=($fpath /usr/local/share/doc/task/scripts/zsh)
# Be verbose, i.e. show descriptions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
# Group by tag names
zstyle ':completion:*' group-name ''
autoload colors && colors
zstyle ':completion:*:*:task:*:arguments' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[blue]" 
zstyle ':completion:*:*:task:*:default' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[green]" 
zstyle ':completion:*:*:task:*:values' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[red]" 
zstyle ':completion:*:*:task:*:commands' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[yellow]" 
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/ifs/.zshrc'
autoload -Uz compinit
compinit -d ~/.zcompdump
source ~/scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
source /etc/environment
