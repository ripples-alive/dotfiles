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

# set proxy to system proxy quickly
function use-system-proxy() {
    if [[ "$(uname -s)" == "Darwin" ]]; then
        local output=$(scutil --proxy)
        local host port
        if [[ "$output" =~ ".*SOCKSEnable : 1.*" ]]; then
            port=${${output/*SOCKSPort : /}/$'\n'*/}
            host=${${output/*SOCKSProxy : /}/$'\n'*/}
            use-proxy "socks5://$host:$port"
        elif [[ "$output" =~ ".*HTTPProxy : 1.*" ]]; then
            port=${${output/*HTTPPort : /}/$'\n'*/}
            host=${${output/*HTTPProxy : /}/$'\n'*/}
            use-proxy "http://$host:$port"
        elif [[ "$output" =~ ".*HTTPSProxy : 1.*" ]]; then
            port=${${output/*HTTPSPort : /}/$'\n'*/}
            host=${${output/*HTTPSProxy : /}/$'\n'*/}
            use-proxy "https://$host:$port"
        fi
    fi
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

# CONFIGURATION VARIABLES
# Automatically use system proxy
: ${USE_SYSTEM_PROXY:=false}

if [[ "$USE_SYSTEM_PROXY" == "true" ]]; then
    use-system-proxy
fi
