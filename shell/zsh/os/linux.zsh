antigen bundle systemd

alias sysuser="systemctl --user"
alias pbcopy=it2copy

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

if [ $commands[bat] ]
then
    alias cat=bat
fi

function at() {
    if [[ "$1" =~ ^[0-9]+$ ]]
    then
        sudo gdb attach $1
    else
        sudo gdb attach `pidof $1`
    fi
}

# get local ip address
function iplocal() {
    local purple="\x1B\[35m" reset="\x1B\[m"
    ip addr | \
        sed -r "s/^[0-9]+:\s*(.*):.*$/\n${purple}\1${reset}/g" | \
        sed -r "s/.*link\S*\s+(\S*)\s.*/📘  \1/g" | \
        sed -r "s/.*inet6?\s+([^\/]+)(\/[0-9]+)?\s.*/📶  \1 \2/g" | \
        grep -v valid_lft | \
        sed "/^${purple}.*@/,/^$/d" | \
        sed "1{/^$/d}" | \
        sed "\${/^$/d}"
}