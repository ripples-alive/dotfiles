# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# mv, rm, cp
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'

alias cask='brew cask'
alias hosts='sudo $EDITOR /etc/hosts'

alias ag='ag -f --hidden'

# use coreutils `ls` if possible…
hash gls >/dev/null 2>&1 || alias gls="ls"

# always use color, even when piping (to awk,grep,etc)
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

# proxychains
if [ $commands[proxychains4] ]
then
    alias p=proxychains4
elif [ $commands[proxychains] ]
then
    alias p=proxychains
fi

# cat/bat
if [ $commands[bat] ]
then
    alias cat="bat --style=header"
fi

# Networking. IP address, dig, DNS
if [ $commands[dig] ]; then
    alias ipglobal="dig +short myip.opendns.com @resolver1.opendns.com"
else
    alias ipglobal="curl -q myip.ipip.net 2>/dev/null | awk -F'：' '{print \$2}' | awk '{print \$1}'"
fi

# Recursively delete `.DS_Store` files
alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"

alias diskspace_report="df -P -kHl"
alias free_diskspace_report="diskspace_report"

# Shortcuts
alias ungz="gunzip -k"
alias tailf="tail -f"

alias dockviz="docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"
alias clean-docker-container='docker ps -aq | xargs docker rm'
alias clean-docker-image='docker images | grep "^<none>" | awk "{print $3}" | xargs docker rmi'
