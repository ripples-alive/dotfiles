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
EOF

if [ $commands[direnv] ]; then
    antigen bundle direnv
fi

# load the theme
antigen theme romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
