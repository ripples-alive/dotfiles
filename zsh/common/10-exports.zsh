# vim as default
export EDITOR="vim"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

export PATH=$HOME/bin:$DOTFILES/bin:$DOTFILES/iterm2:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH
export MANPATH=/usr/local/share/man:/usr/share/man:/usr/local/man:$MANPATH

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Set go path
export GOPATH="${HOME}/.go"
export PATH="${GOPATH//://bin:}/bin:$PATH"
# Set python startup script.
test -e "${HOME}/.pystartup" && export PYTHONSTARTUP="$HOME/.pystartup"

# iTerm2 hostname
export iterm2_hostname=${iterm2_hostname:-${$(hostname -f 2>/dev/null)#ripples-}}
