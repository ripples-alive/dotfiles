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
    urltools
    z

    zsh-users/zsh-autosuggestions

    $ZSH_CUSTOM/plugin/fzf
EOF

# load the theme
antigen theme romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
