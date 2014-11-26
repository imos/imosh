#!/bin/bash

source "$(dirname "${BASH_SOURCE}")"/../../imosh || exit 1
DEFINE_int 'descriptor' 1 'File descriptor to show a message to.'
DEFINE_bool 'close' false 'Close the descriptor beforehand.'
eval "${IMOSH_INIT}"

if (( FLAGS_close )); then
  eval "exec ${FLAGS_descriptor}>&-"
fi
eval "exec ${FLAGS_descriptor}>/dev/null"
eval "echo 'This message should not be shown.' >&${FLAGS_descriptor}"
