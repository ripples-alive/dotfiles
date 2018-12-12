typeset -a __lazyload_compdefs
compdef () { __lazyload_compdefs=($__lazyload_compdefs "$*") }

function lazyload_compdefs() {
    local cdef
    for cdef in "${__lazyload_compdefs[@]}"; do
        eval "compdef $cdef"
    done
}

function lazyload() {
    local command_name=$1
    eval "\
        function _${command_name}() { ;\
            compdef -d ${command_name} ;\
            unfunction ${command_name} ;\
            unfunction _${command_name} ;\
            _load_${command_name} ;\
        } ;\
        function ${command_name}() { ;\
            _${command_name} ;\
            ${command_name} \"\$@\" ;\
        } ;\
        compdef _${command_name} ${command_name} ;\
    "
}

function _load_jenv {
    eval "$(jenv init -)"
}
lazyload jenv
