export DISTRO=$(lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om)

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
alias pa="yay -S"
alias u="yay -Syu"
alias rp="yay -Rs"

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
