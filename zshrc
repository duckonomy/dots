###################
## Basic settings #
###################

# /etc/zshrc: DO NOT EDIT -- this file has been generated automatically.
# This file is read for interactive shells.

# . ~/.zinputrc

# GEOMETRY_PROMPT_PLUGINS=(virtualenv docker_machine exec_time git hg +rustup)
GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time git hg +rustup)

autoload -U compinit && compinit

### If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac

[ -n "$SSH_CONNECTION" ] && unset SSH_ASKPASS
export GIT_ASKPASS=

### Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

TERM=xterm-256color-italic

### Disable Ctrl-S
stty -ixon

setopt appendhistory autocd extendedglob nomatch
unsetopt beep
bindkey -e

autoload -Uz compinit && compinit
zstyle ':completion::complete:*' use-cache 1
# zstyle ':completion::complete:*' cache-path $ZSH_CACHE
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose true
zstyle ':completion:*' rehash true
zstyle ':completion:*' show-completer true
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"
function _set-list-colors() {
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    unfunction _set-list-colors
}
sched 0 _set-list-colors  # deferred since LC_COLORS might not be available yet

zstyle -e ':completion:*' hosts 'reply=()'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs cron mongodb nullmail portage redis \
        shoutcast tcpdump '_*'
zstyle ':completion:*' single-ignored show


###########
# Aliases #
###########
### Colors TODO: Make it check for dircolors present
alias ls='ls -1F --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias anti='antibody bundle < ~/.zsh_plugins > ~/.zsh.d/antibody/.zsh_plugins.sh'
alias vim='nvim'
alias v='nvim'
alias sv='sudo nvim'


###############
# Keybindings #
###############

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey '^[[Z' reverse-menu-complete

### cd variants
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cd.='cd ..'
alias cd..='cd ..'
alias ~='cd'
alias -- -='cd -'

### rsync
alias rsync="rsync -avh --progress"

### Shortcuts
alias db=$DEBUGGER
alias cc=$CC
alias trace=$TRACER
alias k9='kill -9 %%'
alias j="jobs"
alias h="history"
alias b="bg"
alias f="fg"
alias p="pwd"
alias w="whoami"
alias t="tmux"
alias ta="tmux attach"
alias Z="exit"
alias c="clear"

### HEX2DEC & DEC2HEX
alias hex2dec="printf '%d\n'"
alias dec2hex="printf '0x%x\n'"

### Vim
alias vi='nvim'
alias sv="sudo nvim"
alias vim="nvim"
alias vimdiff='nvim -d'
alias v="vim"

### Emacs
alias e="emacsclient -c -a -q -n"
alias et="emacsclient -t -a -q"

### Git
alias gitv='git log --graph --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias gp='git push'
alias grm='git rm $(git ls-files --deleted)'
github_user="duckonomy"

function git-fork() {
    local user=$1
    if [[ "$user" == "" ]]; then
        echo "Usage: git-fork <original-author>"
    else
        local repo=`basename "$(pwd)"`
        git remote add upstream "git@github.com:$user/$repo.git"
    fi
}

function git-github() {
    local repo=${1-`basename "$(pwd)"`}
    git remote add origin "git@github.com:$github_user/$repo.git"
    git push -u origin master
}

# Setup syncronization of current Git repo with Bitbucket repo of the same name
# USAGE: git-bitbucket [repo]
function git-bitbucket() {
    local repo=${1-`basename "$(pwd)"`}
    git remote add origin "git@bitbucket.org:$bitbucket_user/$repo.git"
    git push -u origin master
}

function git-upstream() {
    local branch=${1-master}
    git fetch upstream
    git checkout $branch
    git rebase upstream/$branch
}

# Add all staged files to previous commit
function git-append() {
    git log -n 1 --pretty=tformat:%s%n%n%b | git commit -F - --amend
}

# List of files with unresolved conflicts
function git-conflicts() {
    git ls-files -u | awk '{print $4}' | sort -u
}


### Hub (https://github.com/github/hub)
# alias git=hub

### OS-specific aliases
if [ -d "$HOME/.zsh.d/os" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        . $HOME/.zsh.d/os/linux.zsh
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        . $HOME/.zsh.d/os/darwin.zsh
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        . $HOME/.zsh.d/os/cygwin.zsh
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        . $HOME/.zsh.d/os/freebsd.zsh
    else
        . $HOME/.zsh.d/os/other
    fi
fi

### Private alias
if [ -f "$HOME/.zsh.d/private.zsh" ]; then
    . $HOME/.zsh.d/private.zsh
fi


#######
# FZF #
#######

fzf-down() {
    fzf --height 50% "$@" --border
}

fp() {
    local loc=$(echo $PATH | sed -e $'s/:/\\\n/g' | eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:path]'")

    if [[ -d $loc ]]; then
        echo "$(rg --files $loc | rev | cut -d"/" -f1 | rev)" | eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:exe] => ${loc}' >/dev/null"
        fp
    fi
}

kp() {
    local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
        kp
    fi
}

ks() {
    local pid=$(lsof -Pwni tcp | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:tcp]'" | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
        ks
    fi
}

lf() {
    if hash tree &>/dev/null; then
        if [[ "x$1" != "x" ]]
        then
            local is_first="1"
            for i
            do
                if [[ "$is_first" = "1" ]]
                then
                    is_first="0"
                else
                    print "\n"
                fi
                tree -ahpCI '*git' --dirsfirst $i
            done
        else
            tree -ahpCI '*git' --dirsfirst
        fi
    fi
}

lx() {
    if hash exa &>/dev/null; then
        if [[ "x$1" != "x" ]]
        then
            local is_first="1"
            for i
            do
                if [[ "$is_first" = "1" ]]
                then
                    is_first="0"
                else
                    print "\n"
                fi
                echo $i
                exa -aBhg --long --group-directories-first --time-style=long-iso $i
            done
        else
            exa -aBhg --long --group-directories-first --time-style=long-iso
        fi
    fi
}

vmc() {
    local lang=${1}

    if [[ -z $lang ]]; then
        lang=$(asdf plugin-list | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[asdf:clean]'")
    fi

    if [[ $lang ]]; then
        for lng in $(echo $lang); do
            for version in $(asdf list $lng | sort -nrk1,1 | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[asdf:${lng}:clean]'")
            do asdf uninstall $lng $version
            done
        done
    fi
}

vmi() {
    local lang=${1}
    asdf plugin-list-all &>/dev/null 2>&1

    if [[ -z $lang ]]; then
        lang=$(asdf plugin-list-all | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[asdf:install]'")
    fi

    if [[ $lang ]]; then
        for lng in $(echo $lang); do
            if [[ -z $(asdf plugin-list | rg $lng) ]]; then
                asdf plugin-add $lng
            else
                asdf plugin-update $lng
            fi

            for version in $(asdf list-all $lng | sort -nrk1,1 | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[asdf:${lng}:install]'")
            do asdf install $lng $version
            done
        done
    fi
}

### When using vi mode
# set -o vi

########################
# Convenient Functions #
########################

function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        return 1
    else
        for n in $@
        do
            if [ -f "$n" ] ; then
                case "${n%,}" in
                    *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                        tar xvf "$n"       ;;
                    *.lzma)      unlzma ./"$n"      ;;
                    *.bz2)       bunzip2 ./"$n"     ;;
                    *.rar)       unrar x -ad ./"$n" ;;
                    *.gz)        gunzip ./"$n"      ;;
                    *.zip)       unzip ./"$n"       ;;
                    *.z)         uncompress ./"$n"  ;;
                    *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                        7z x ./"$n"        ;;
                    *.xz)        unxz ./"$n"        ;;
                    *.exe)       cabextract ./"$n"  ;;
                    *)
                        echo "extract: '$n' - unknown archive method"
                        return 1
                        ;;
                esac
            else
                echo "'$n' - file does not exist"
                return 1
            fi
        done
    fi
}


#####
# Z #
#####

### Get z
. ~/.zsh.d/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--height 40% --reverse'

###########
# Plugins #
###########

. ~/.zsh.d/antibody/zsh_plugins.sh



##########
# Quirks #
##########

### Various methods of getting making alt-backspace stop at non-alphanumeric

# METHOD 1 : works but longer
# tcsh-backward-delete-word () {
#     local WORDCHARS="${WORDCHARS:s#/#}"
#     zle backward-delete-word
# }

# zle -N tcsh-backward-delete-word
# bindkey '^[^?' tcsh-backward-delete-word

# METHOD 2 doesn't work (they say that it should)
autoload -U select-word-style
select-word-style bash

# METHOD 3
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

if [ "$TERM" != dumb ]; then
    autoload -U promptinit && promptinit && prompt walters
fi

# TERM=xterm-256color-italic
#
#
