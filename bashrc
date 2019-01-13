##################
# Basic settings #
##################

### Check the window size after each command ($LINES, $COLUMNS)
[[ $DISPLAY ]] && shopt -s checkwinsize

### Append to the history file
shopt -s histappend

### Better-looking less for binary files
[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe.sh)"

### Bash completion (ARCH)
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

### Disable Ctrl-S
stty -ixon

##########
# Prompt #
##########

. ~/.sh.d/prompt.bash


###########
# Aliases #
###########

### ls variants
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls -1F --color=auto'
    alias grep='grep --color=auto'
elif [ "$OSTYPE" = darwin ]; then
    alias ls='ls -G'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
alias git=hub

### OS-specific aliases
if [ -d "$HOME/.sh.d/os" ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        . $HOME/.sh.d/os/linux.bash
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        . $HOME/.sh.d/os/darwin.bash
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        . $HOME/.sh.d/os/cygwin.bash
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        . $HOME/.sh.d/os/freebsd.bash
    else
        . $HOME/.sh.d/os/other
    fi
fi

### Private alias
if [ -f "$HOME/.sh.d/private.bash" ]; then
    . $HOME/.sh.d/private.bash
fi


#######
# FZF #
#######

fzf-down() {
    fzf --height 50% "$@" --border
}

### When using vi mode
# set -o vi

[ -f ~/.sh.d/fzf.bash ] && source ~/.sh.d/fzf.bash

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
. ~/.sh.d/z.sh
