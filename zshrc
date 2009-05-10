# Written for zsh-4.3.9
# Have been tested with bash-3.1.17(2)

# Select your shell with this variable; have been tested with zsh and bash.
export SHELL="/bin/zsh"

# ------------------------------------------------------------------------------
# -- Set some options --
if [[ $SHELL =~ ".*zsh$" ]]; then
   unlimit
   limit stack 8192
   limit core     0
   limit -s
   # Load colors :)
   autoload -U colors
   colors
fi
umask 022

# ------------------------------------------------------------------------------
# -- Set the path --
# First, a single function to add an element to the path.
# XXX Cannot use bash's references in zsh.
function add_path () { [ -d "$1" ] && PATH=$PATH:"$1"; }
function add_mpath () { [ -d "$1" ] && MANPATH=$MANPATH:"$1"; }
# Now, set it.
PATH="/bin:/usr/bin:/usr/games"
add_path "/usr/local/bin"
add_path "/usr/bin/pkg"
add_path "/usr/lib/java/bin"
add_path "/usr/lib/java/jre/bin"
add_path "/usr/lib/qt/bin"
add_path "/usr/shame/texmf/bin"
add_path "/home/mathieu/bin"

add_mpath "/usr/local/share/man"
add_mpath "/usr/share/man"
export PATH
export MANPATH

# Remove duplicates.
[[ "$SHELL" =~ '.*zsh' ]] && typeset -U path cdpath fpath manpath

# ------------------------------------------------------------------------------
# -- Aliases --
# We assume that we use the GNU ls only if we run a Linux based OS.
[[ `uname` =~ 'Linux' ]] && alias ls="ls --color=auto -h" || alias ls="ls -h"
# Some shortucts for ls.
alias l=ls
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -l -a"

if [[ $SHELL =~ '.*zsh' ]]; then
   alias lsd="ls -ld *(-/DN)"
   alias cp="nocorrect cp -v"
   alias mv="nocorrect mv -v"
   alias mkdir="nocorrect mkdir -v"
   alias xset="nocorrect xset"
   alias find="noglob find"
   alias grep="noglob egrep"
   # Enjoy :)
   alias -g M=' | more'
   alias -g L=' | less'
   alias -g H=' | head'
   alias -g T=' | tail'
else
   alias lsd="ls -l | grep '^d'"
   alias cp="cp -v"
   alias mv="mv -v"
   alias mkdir="mkdir -v"
   alias grep=egrep
fi

# Human readable format.
alias df="df -h"
alias du="du -h"

alias rm="rm -v"

# Get IP address.
alias myip="wget checkip.dyndns.org -qO /dev/stdout | cut -d'/' -f3 | rev \
           | awk '{ print \$1 }' | colrm 1 1 | rev"

if [[ -x /usr/bin/most || -x /usr/local/bin/most || -x /usr/pkg/bin/most ]];then
   alias most="most -ct3 -s"
   alias m=most
   alias lm="ls | most"
   alias llm="ls -l | most"
   export PAGER="most -ct3 -s"
   [[ $SHELL =~ '.*zsh' ]] && alias -g M=' | most'
fi

# Reload ratpoison configuration.
rat_reload='ratpoison -c "source /home/mathieu/.ratpoisonrc"'

# Pretty basic text formatting with sed.
alias center="sed -e :a -e 's/^.\{1,79\}$/ &/;ta' -e 's/\( *\)\1/\1/'"
alias fold_left="sed -e :a -e 's/^.\{1,78\}$/ &/;ta'"

# Some general shortcuts.
alias a=alsamixer
alias c=clear
alias f=whereis
alias j=jobs
alias p=pwd
alias t=type
alias v=vim
alias ..="cd .."

# ------------------------------------------------------------------------------
# -- Zsh special features --
if [[ $SHELL =~ ".*zsh" ]]; then
   # Watch users {de,}connexions every 5 minutes.
   watch=(notme)
   LOGGCHECK=300
   WATCHFMT="%n %a %l from %m at %t."
   # Hostname completion.
   hosts=(`hostname` izu.ath.cx morag.polytech.unice.fr localhost 127.0.0.1)
   # Check mail every 5 minutes.
   MAILCHECK=300
   # Size of the history.
   HISTSIZE=666
   # Size of the directory stack.
   DIRSTACKSIZE=42

   # Set some options.
   setopt   notify globdots correct pushdtohome cdablevars autolist
   setopt   correctall autocd recexact longlistjobs
   setopt   autopushd pushdminus extendedglob rcquotes mailwarning
   setopt   nobeep
   unsetopt bgnice autoparamslash

   # Load some modules.
   zmodload -a  zsh/stat    stat
   zmodload -a  zsh/zpty    zpty
   zmodload -a  zsh/zprof   zprof
   zmodload -ap zsh/mapfile mapfile

   # Completion system.
   zstyle ':completion:*' completer _complete _ignored
   zstyle :compinstall filename '/home/mathieu/.zshrc'
   autoload -Uz compinit
   compinit
fi

# ------------------------------------------------------------------------------
# -- Globals variables --
# Yes we do want utf-8.
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_ALL=""

# Some options for less.
export LESS="-cex3M"
export LESSCHARSET="utf-8"

# Vim powered.
export EDITOR=vim
export SVN_EDITOR=vim

# Don't user $USERNAME for bash compatibility.
export MAIL=/var/mail/$USER

# Correct a friggin output bug with ratpoison.
export AWT_TOOLKIT=MToolkit

# ------------------------------------------------------------------------------
# -- Set the prompt --
# Keep it simple: hostname and a tiny %.
if [[ $SHELL =~ '.*zsh' ]];then
   PROMPT="%{${fg[green]}%}%m%{${fg[red]}%}%# %{${fg[white]}%}%b"
else
   PS1="\[\033[0;32m\]\$(hostname)\[\033[0;31m\]% \[\033[0;37m\]"
fi

# vim: ft=zsh
