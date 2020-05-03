# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_";
}

# find shorthand
function f() {
    find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
    local tmpFile="${@%/}.tar";
    tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

    size=$(
        stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
        stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
    );

    local cmd="";
    if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
        # the .tar file is smaller than 50 MB and Zopfli is available; use it
        cmd="zopfli";
    else
        if hash pigz 2> /dev/null; then
            cmd="pigz";
        else
            cmd="gzip";
        fi;
    fi;

    echo "Compressing .tar using \`${cmd}\`…";
    "${cmd}" -v "${tmpFile}" || return 1;
    [ -f "${tmpFile}" ] && rm "${tmpFile}";
    echo "${tmpFile}.gz created successfully.";
}

function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg ./*;
    fi;
}

# Upload files to ssh server
function syncup() {
    local red="\x1B[31m" reset="\x1B[m"
    if [ $# != 2 ]
    then
        echo "Usage: $0 <server> <path>"
        return -1
    fi

    # Format sync path
    file_path=$(realpath -s --relative-base ~ -e "$2") || return -1
    if [[ "$file_path" == /* ]]
    then
        echo "Sync files outside of home directory is now allowed!"
        return -1
    fi
    # ATTENTION: remove sync dir prefix
    file_path=${file_path/cloud\//}

    dir_path=$(dirname $file_path)
    echo "${red}rsync -avz ~/\"$file_path\" \"$1:~/\\\"$dir_path/\\\"\"${reset}"
    rsync -avz ~/"$file_path" "$1:~/\"$dir_path/\""
}
compdef syncup=ssh

# Download files from ssh server
function syncdown() {
    local red="\x1B[31m" reset="\x1B[m"
    if [ $# != 2 ]
    then
        echo "Usage: $0 <server> <path>"
        return -1
    fi

    # Format sync path
    file_path=$(realpath -s --relative-base ~ "$2") || return -1
    if [[ "$file_path" == /* ]]
    then
        echo "Sync files outside of home directory is now allowed!"
        return -1
    fi
    # ATTENTION: remove sync dir prefix
    file_path=${file_path/cloud\//}

    dir_path=$(dirname $file_path)
    echo "${red}rsync -avz \"$1:~/\\\"$file_path\\\"\" ~/\"$dir_path/\"${reset}"
    rsync -avz "$1:~/\"$file_path\"" ~/"$dir_path/"
}
compdef syncdown=syncup

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@";
    }
fi;

# whois a domain or a URL
function whois() {
    local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
    if [ -z $domain ] ; then
        domain=$1
    fi
    echo "Getting whois record for: $domain …"

    # avoid recursion
    # this is the best whois server
    # strip extra fluff
    /usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

# Create a data URL from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1");
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8";
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
    if [ -t 0 ]; then # argument
        python -mjson.tool <<< "$*" | pygmentize -l javascript;
    else # pipe
        python -mjson.tool | pygmentize -l javascript;
    fi;
}

# UTF-8-encode a string of Unicode symbols
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

# Get a character’s Unicode code point
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified.";
        return 1;
    fi;

    local domain="${1}";
    echo "Testing ${domain}…";
    echo ""; # newline

    local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
        | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText=$(echo "${tmp}" \
            | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
            no_serial, no_sigdump, no_signame, no_validity, no_version");
        echo "Common Name:";
        echo ""; # newline
        echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
        echo ""; # newline
        echo "Subject Alternative Name(s):";
        echo ""; # newline
        echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
            | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
        return 0;
    else
        echo "ERROR: Certificate not found.";
        return 1;
    fi;
}

# `c` with no arguments opens the current directory in VS Code, otherwise opens the
# given location
function c() {
    if [ $# -eq 0 ]; then
        code .;
    else
        code "$@";
    fi;
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v() {
    if [ $# -eq 0 ]; then
        vim .;
    else
        vim "$@";
    fi;
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
    if [ $# -eq 0 ]; then
        open .;
    else
        open "$@";
    fi;
}

# preview csv files. source: http://stackoverflow.com/questions/1875305/command-line-csv-viewer
function csvpreview(){
    sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t | less -#2 -N -S
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
function gifify() {
    if [[ -n "$1" ]]; then
        if [[ $2 == '--good' ]]; then
        ffmpeg -i "$1" -r 10 -vcodec png out-static-%05d.png
        time convert -verbose +dither -layers Optimize -resize 900x900\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > "$1.gif"
        rm out-static*.png
        else
        ffmpeg -i "$1" -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > "$1.gif"
        fi
    else
        echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
    fi
}

# direct it all to /dev/null
function nullify() {
    "$@" >/dev/null 2>&1
}

# set proxy quickly
function use-proxy() {
    if [ $# != 2 ] && [ $# != 1 ]
    then
        echo "Usage: $0 [host] <port>"
        return -1
    fi

    local proxy
    if [ $# = 1 ]
    then
        if [[ "$1" =~ ".*://.*" ]]
        then
            proxy="$1"
        else
            proxy="http://127.0.0.1:$1"
        fi
    else
        proxy="http://$1:$2"
    fi
    echo "Use proxy $proxy"
    export http_proxy=$proxy
    export https_proxy=$proxy
    export all_proxy=$proxy
}

# clear proxy quickly
function clear-proxy() {
    unset http_proxy https_proxy all_proxy
}

# show proxy quickly
function show-proxy() {
    echo "http:  $http_proxy"
    echo "https: $https_proxy"
    echo "all:   $all_proxy"
}

# rename tmux pane
rename-pane () {
    read "pane_name?Enter Pane Name: "
    printf "\033]2;%s\033\\" "${pane_name}"
}

# coyp the contents of a given file to the system
function copyfile {
    emulate -L zsh
    $commands[cat] $1 | it2copy
}

# copy the pathname of a given directory to the system
function copypath {
    emulate -L zsh
    if [ $# = 0 ]
    then
        print -n $PWD | it2copy
    else
        printf "%s" "$(realpath $1)" | it2copy
    fi
}

# run ctf-box docker container
alias run-ctf-box-1604='docker run -dit --name ctf-box-1604-$(basename $(pwd)) --rm --privileged -p 1604:22 -P -v $PWD:/root/workspace ripples/ctf-box:16.04'
alias run-ctf-box-1804='docker run -dit --name ctf-box-1804-$(basename $(pwd)) --rm --privileged -p 1804:22 -P -v $PWD:/root/workspace ripples/ctf-box:18.04'
