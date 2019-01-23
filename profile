### https://superuser.com/a/583502/225931
# if [ -f /etc/profile ]; then
#   PATH=
#   source /etc/profile
# fi

### Language settings
# LC_COLLATE=en_US.UTF-8
# LC_CTYPE=en_US.UTF-8
# LC_MESSAGES=en_US.UTF-8
# LC_MONETARY=en_US.UTF-8
# LC_NUMERIC=en_US.UTF-8
# LC_TIME=en_US.UTF-8
# LC_ALL=en_US.UTF-8
# LANG=en_US.UTF-8
# LANGUAGE=en_US.UTF-8
# LESSCHARSET=utf-8
#TZ= Asia/Seoul


### for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000


### PATH
# PATH=/bin:/sbin:/usr/bin/:/usr/sbin:/usr/local/bin:/usr/local/sbin
# PATH=$HOME/.bin:$HOME/.bin/pkgs:$HOME/.fzf/bin:$HOME/.cargo/bin:$HOME/.bin/npm/bin:$PATH
# GOPATH=$HOME/.go


### Editor
# EDITOR=nvim
# VISUAL=$EDITOR
# PAGER='less -R'
# MANWIDTH=80
# TERM=xterm-256color-italic
# TERM=screen-256color


### Compiler
CC=cc
DEBUGGER=gdb
TRACER=strace
TASKDDATA=$HOME/var/taskd


### Other
# GPG_TTY=$(tty)

export CC DEBUGGER TRACER TASKDDATA


# export LC_COLLATE LC_CTYPE LC_MESSAGES LC_MONETARY LC_NUMERIC \
#        LC_TIME LC_ALL LANG LANGUAGE LESSCHARSET PATH GOPATH EDITOR \
#        VISUAL PAGER MANWIDTH TERM CC DEBUGGER TRACER GPG_TTY HISTSIZE HISTFILESIZE


# . ~/.bashrc


### Auto startx when on linux
# if [[ "$OSTYPE" == "linux-gnu" ]]; then
#     if [ -f $HOME/.sh.d/os/linux-env.bash ]; then
#        . $HOME/.sh.d/os/linux-env.bash
#     fi

#     if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#         exec startx -- -ardelay 200 -arinterval 50
#     fi
# fi

# When on mac
#export COPYFILE_DISABLE=true