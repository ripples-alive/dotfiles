# load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundles <<EOF
    colored-man-pages
    colorize
    docker
    docker-compose
    extract
    git
    httpie
    sudo
    tmux
    z

    zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting

    $ZSH_CUSTOM/plugin/fzf
EOF

# load the theme
antigen theme $ZSH_CUSTOM/theme ripples-ys
