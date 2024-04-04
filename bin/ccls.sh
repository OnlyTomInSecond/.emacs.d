#!/bin/bash

ccls_bin=$(whereis ccls | cut -d ':' -f 2)
exec ${ccls_bin} --init="$(cat ~/.emacs.d/configs/ccls_config.json)" --log-file=${PREFIX}/tmp/ccls.log "$@"
