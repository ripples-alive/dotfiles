antigen bundle osx
antigen bundle brew

# Don't show context unless running with privileges or in SSH.
typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

alias timeout=gtimeout
alias sudoedit="sudo vim"
alias locate=glocate
alias updatedb="sudo gupdatedb"
alias sed=gsed

# toggle iTerm Dock icon
# add this to your .bash_profile or .zshrc
function toggle() {
    pb='/usr/libexec/PlistBuddy'
    iTerm="/Applications/$@.app/Contents/Info.plist"

    echo "Do you wish to hide $@ in Dock?"
    select ync in "Hide" "Show" "Cancel"; do
        case $ync in
            'Hide' )
                $pb -c "Add :LSUIElement bool true" $iTerm
                echo "relaunch $@ to take effectives"
                break
                ;;
            'Show' )
                $pb -c "Delete :LSUIElement" $iTerm
                echo "run killall '$@' to exit, and then relaunch it"
                break
                ;;
        'Cancel' )
            break
            ;;
        esac
    done
}
