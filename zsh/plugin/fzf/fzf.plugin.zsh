if [ -d ~/.fzf ]; then
    FZF_PATH=~/.fzf
elif [ $commands[brew] ] && [ -d $(brew --prefix)/opt/fzf ]; then
    FZF_PATH=$(brew --prefix)/opt/fzf
fi

if [ -n "$FZF_PATH" ]; then
    # Setup fzf
    # ---------
    if [[ ! "$PATH" == *$FZF_PATH/bin* ]]; then
        export PATH="$PATH:$FZF_PATH/bin"
    fi

    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "$FZF_PATH/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------
    source "$FZF_PATH/shell/key-bindings.zsh"

    fzf-history-widget-accept() {
        fzf-history-widget
        zle accept-line
    }
    zle -N fzf-history-widget-accept
    bindkey '\er' fzf-history-widget
    bindkey '^R' fzf-history-widget-accept

    export FZF_CTRL_R_OPTS="--exact --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
    export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

    source function.zsh
    source fz.zsh
    source zsh-interactive-cd.zsh
fi
