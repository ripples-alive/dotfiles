# operating system specific settings
case "$(uname -s)" in

    Darwin)
        source $ZSH_CUSTOM/os/macos.zsh
        ;;

    Linux*)
        source $ZSH_CUSTOM/os/linux.zsh
        ;;

    CYGWIN*|MINGW32*|MSYS*)
        ;;

    *)
        ;;

esac

# host specific settings
test -e "${ZSH_CUSTOM}/host/${HOST}.zsh" && source "${ZSH_CUSTOM}/host/${HOST}.zsh"
