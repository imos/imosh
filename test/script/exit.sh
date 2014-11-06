#!/bin/bash
# Test func::exit.

source "$(dirname "${BASH_SOURCE}")"/../../imosh || exit 1
DEFINE_int 'status' 0 'Status code to exit.'
DEFINE_int 'depth' 0 'Max depth of subprocesses.'
DEFINE_int 'exit_depth' 0 'Depth of a subprocess calling func::exit.'
eval "${IMOSH_INIT}"

f() {
  local depth="$1"
  local primary="$2"
  LOG INFO "Function: f ${depth} ${primary}"
  if [ "${depth}" -gt 0 ]; then
    f "$(( depth - 1 ))" 0 &
    f "$(( depth - 1 ))" "${primary}" &
  fi
  if (( primary && depth == FLAGS_exit_depth )); then
    sleep 0.1
    LOG INFO "Calling func::exit ${FLAGS_status}"
    func::exit "${FLAGS_status}"
    exit
  fi
  sleep 5
  echo failure
}

f "${FLAGS_depth}" 1 &
sleep 5
exit 1
