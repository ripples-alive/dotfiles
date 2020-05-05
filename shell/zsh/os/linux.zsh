antigen bundle systemd

alias sysuser="systemctl --user"
alias pbcopy=it2copy

export PATH="$PATH:/snap/bin"

if [[ -d "/home/linuxbrew/.linuxbrew" ]]
then
    antigen bundle brew
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
    export MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man"
    export INFOPATH="$INFOPATH:/home/linuxbrew/.linuxbrew/share/info"
elif [[ -d "$HOME/.linuxbrew" ]]
then
    antigen bundle brew
    export PATH="$PATH:$HOME/.linuxbrew/bin"
    export MANPATH="$MANPATH:$HOME/.linuxbrew/share/man"
    export INFOPATH="$INFOPATH:$HOME/.linuxbrew/share/info"
fi

function at() {
    if [[ "$1" =~ ^[0-9]+$ ]]
    then
        sudo gdb attach $1
    else
        sudo gdb attach `pidof $1`
    fi
}
