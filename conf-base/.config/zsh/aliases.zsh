#!/bin/sh

# pacman
alias \
    p='pacman' \
    sp='sudo pacman' \
    sps='sudo pacman -S' \
    spr='sudo pacman -R' \
    pq='pacman -Q'

# Verbosity and settings that you pretty much just always are going to want.
alias \
    cp="cp -iv" \
    mv="mv -iv" \
    rm="rm -vI" \
    bc="bc -ql" \
    rsync="rsync -vrPlu" \
    mkd="mkdir -pv" \
    yt="yt-dlp --embed-metadata -i" \
    yta="yt -x -f bestaudio/best" \
    ytt="yt --skip-download --write-thumbnail" \
    ffmpeg="ffmpeg -hide_banner"

# Color
# alias ls="ls -hN --color=auto --group-directories-first"
# Show all options in case of revert to ls
alias \
    ls='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first' \
    la='eza -A --color=always --grid --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first' \
    ll='eza --color=always --long --git --icons=always' \
    lla='eza -A --color=always --long --git --icons=always' \
    grep="grep --color=auto" \
    diff="diff --color=auto" \
    ccat="highlight --out-format=ansi" \
    ip="ip -color=auto"

alias \
    z="zathura" \
    g="git" \
    yz="yazi"

alias gnv='nvim --listen ~/.cache/nvim/godot.pipe'
alias \
    nv='nvim' \
    conf="yazi $HOME/.config/" \
    dotf="yazi $HOME/.dotfiles/" \
    roblox="cd /home/joan/.var/app/io.github.vinegarhq.Vinegar/data/vinegar/prefix/dosdevices/c:/users/joan/Documents" \
    studio="flatpak run io.github.vinegarhq.Vinegar studio"

alias gpt="com.microsoft.Edge --app='https://www.bing.com/search?form=NTPCHB&q=Bing+AI&showconv=1' &"
alias scripts="cd ~/.local/bin/"

# Winget dotfile change location
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

