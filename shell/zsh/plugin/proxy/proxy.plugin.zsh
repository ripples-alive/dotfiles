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
