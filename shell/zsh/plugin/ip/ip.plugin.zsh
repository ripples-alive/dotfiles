# get local ip address
if [[ "$(uname -s)" == "Darwin" ]]; then
    function iplocal() {
        local purple="\x1B\[35m" reset="\x1B\[m"
        if [ $commands[ip] ]; then
            local cmd="$(command -v ip) addr show"
            if [ $# = 1 ]; then
                cmd="$cmd dev $1"
            fi
            $SHELL -c $cmd | \
                sed -r "s/^(\S*):.*$/\n${purple}\1${reset}/g" | \
                sed -r "s/\s+ether\s+(\S*)/📘  \1/g" | \
                sed -r "s/.*inet6?\s+([^\/]+)(\/[0-9]+)?.*/📶  \1 \2/g" | \
                grep -v valid_lft | \
                sed "/^${purple}.*@/,/^$/d" | \
                sed "1{/^$/d}" | \
                sed "\${/^$/d}"
        else
            networksetup -listallhardwareports | \
                sed -r "s/Hardware Port: (.*)/${purple}\1${reset}/g" | \
                sed -r "s/Device: (.*)$/ipconfig getifaddr \1/e" | \
                sed -r "s/(^[0-9.]+$)/📶  \1/g" | \
                sed -r "s/Ethernet Address:/📘 /g" | \
                sed -r "/(VLAN Configurations)|==*/d" | \
                sed -r "/^$/d" | \
                sed -r "2,\${s/(^${purple})/\n\1/g}"
        fi
    }
else
    function iplocal() {
        local purple="\x1B\[35m" reset="\x1B\[m"
        local cmd="$(command -v ip) addr show"
        if [ $# = 1 ]; then
            cmd="$cmd dev $1"
        fi
        $SHELL -c $cmd | \
            sed -r "s/^[0-9]+:\s*(.*):.*$/\n${purple}\1${reset}/g" | \
            sed -r "s/.*link\S*\s+(\S*)\s.*/📘  \1/g" | \
            sed -r "s/.*inet6?\s+([^\/]+)(\/[0-9]+)?\s.*/📶  \1 \2/g" | \
            grep -v valid_lft | \
            sed "/^${purple}.*@/,/^$/d" | \
            sed "1{/^$/d}" | \
            sed "\${/^$/d}"
    }
fi

# get global ip address
if [ $commands[dig] ]; then
    alias ipglobal="dig +short myip.opendns.com @resolver1.opendns.com"
else
    alias ipglobal="curl -q myip.ipip.net 2>/dev/null | awk -F'ï¼š' '{print \$2}' | awk '{print \$1}'"
fi
