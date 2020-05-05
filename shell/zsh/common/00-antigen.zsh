# load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundles <<EOF
    colored-man-pages
    colorize
    command-not-found
    cp
    dirpersist
    docker
    docker-compose
    extract
    git
    gitignore
    httpie
    man
    pip
    python
    sudo
    transfer
    urltools
    z

    zsh-users/zsh-autosuggestions

    $ZSH_CUSTOM/plugin/fzf
    $ZSH_CUSTOM/plugin/ip
    $ZSH_CUSTOM/plugin/proxy
EOF

if [ $commands[direnv] ]; then
    antigen bundle direnv
fi
