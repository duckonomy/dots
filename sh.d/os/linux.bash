export DISTRO=$(lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om)

#########
# Alias #
#########

### Shortcuts
alias x="startx"
alias fcv="fc-cache -vf"

### systemd
alias sb="sudo systemctl stop bluetooth"
alias tb="sudo systemctl start bluetooth"
alias clearjournal="journalctl --vacuum-time=2d"

### USB
alias musb="udisksctl mount --block-device"
alias umusb="udisksctl unmount --block-device"
alias musbt="udisksctl mount --block-device /dev/sdb1"
alias umusbt="udisksctl unmount --block-device /dev/sdb1"

### Pacman
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [ "$OS" == 'Arch Linux' ]; then
    alias pa="yay -S"
    alias u="yay -Syu"
    alias rp="yay -Rs"
elif [ "$OS" == 'Ubuntu' ]; then
    alias pa="sudo apt-get install"
    alias u="sudo apt-get update && sudo apt-get upgrade"
    alias rp="sudo apt-get remove"
fi

### GTK bindings
alias defaultkeys="gsettings set org.gnome.desktop.interface gtk-key-theme \"Default\""
alias emacskeys="gsettings set org.gnome.desktop.interface gtk-key-theme \"Emacs\""

### Hangul
alias mp3conv='find -type f -iregex ".*/.*\.\(ogg\|mp3\|flac\)" -print0 | xargs -0 mid3iconv -e cp949'
alias unzip="unzip"
# alias unzip="unzip -O cp949"

### Sxiv
alias sxiv="sxiv-rifle"

### Timeset (do after `sudo tzupdate`)
alias timesync='systemctl restart systemd-timesyncd'
alias timeset1="sudo ntpdate pool.ntp.org"
alias timeset2="sudo clockdiff pool.ntp.org"


#############
# Functions #
#############

if [[ $DISTRO = "Arch" ]]; then
    # Pacman install
    function pif {
        local package_list=`pacman -Ss | sed 'n; d' | cut -d '/' -f 2 | cut -d ' ' -f 1 | fzf -m --header='[pacman:install]'`

        if [[ $package_list ]]; then
            for prog in $(echo $package_list)
            do yay -S $prog
            done
        fi
    }

    # Pacman remove
    function prf {
        local package_list=`pacman -Qqe | fzf -m --header='[pacman:remove]'`

        if [[ $package_list ]]; then
            for prog in $(echo $package_list)
            do yay -Rs $prog
            done
        fi
    }

    # AUR install
    function piif {
        local package_list=`wget -P "/tmp/aur/" "https://aur.archlinux.org/packages.gz" &>/dev/null && gunzip -f "/tmp/aur/packages.gz" | sort /tmp/aur/packages | fzf -m --header='[aur:install]'`

        if [[ $package_list ]]; then
            for prog in $(echo $package_list)
            do yay -S $prog
            done
        fi
    }

elif [[ $DISTRO = "Ubuntu" ]]; then
    # Pacman install
    function pif {
        local package_list=`apt-cache search . | cut -d ' ' -f 1 | fzf -m --header='[apt:install]'`

        if [[ $package_list ]]; then
            for prog in $(echo $package_list)
            do sudo apt install $prog
            done
        fi
    }

    # Pacman remove
    function prf {
        local package_list=`dpkg -l | grep "^ii" | awk '{print $2}' | fzf -m --header='[apt:remove]'`

        if [[ $package_list ]]; then
            for prog in $(echo $package_list)
            do sudo apt remove $prog
            done
        fi
    }
fi
