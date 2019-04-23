antigen bundle osx
antigen bundle brew

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

# get local ip address
function iplocal() {
    local purple="\x1B\[35m" reset="\x1B\[m"
    networksetup -listallhardwareports | \
        sed -r "s/Hardware Port: (.*)/${purple}\1${reset}/g" | \
        sed -r "s/Device: (.*)$/ipconfig getifaddr \1/e" | \
        sed -r "s/(^[0-9.]+$)/📶  \1/g" | \
        sed -r "s/Ethernet Address:/📘 /g" | \
        sed -r "/(VLAN Configurations)|==*/d" | \
        sed -r "/^$/d" | \
        sed -r "2,\${s/(^${purple})/\n\1/g}"
}
