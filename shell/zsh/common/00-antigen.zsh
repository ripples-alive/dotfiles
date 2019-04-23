# load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundles <<EOF
    colored-man-pages
    colorize
    copydir
    copyfile
    cp
    docker
    docker-compose
    extract
    git
    httpie
    pip
    sudo
    tmux
    urltools
    z

    zsh-users/zsh-autosuggestions

    $ZSH_CUSTOM/plugin/fzf
EOF

# load the theme
antigen theme $ZSH_CUSTOM/theme ripples-ys
