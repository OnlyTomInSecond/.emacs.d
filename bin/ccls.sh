#!/bin/bash
exec "/usr/bin/ccls" --init="$(cat ~/.emacs.d/configs/ccls_config.json)" --log-file=/tmp/ccls.log "$@"
