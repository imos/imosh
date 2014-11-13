# Usage:
#   imosh::stack_trace [--skip_imosh] [message...]
#
# Shows a stack trace.  Arguments are used as a message.
imosh::stack_trace() {
  local ARGS_skip_imosh=0
  eval "${IMOSH_PARSE_ARGUMENTS}"

  local max_depth="${#BASH_LINENO[*]}"
  local i=0
  if [ "$*" = '' ]; then
    echo 'imosh::stack_trace is called' >&2
  else
    echo "$*" >&2
  fi
  while (( i < max_depth - 1 )); do
    if [ "${BASH_SOURCE[$((i+1))]}" != "${BASH_SOURCE[0]}" ]; then
      break
    fi
    (( i += 1 )) || true
  done
  while (( i < max_depth - 1 )); do
    local lineno="${BASH_LINENO[$((i))]}"
    local file="${BASH_SOURCE[$((i+1))]}"
    local function="${FUNCNAME[$((i+1))]}"
    echo "  at ${function} (${file}:${lineno})" >&2
    (( i += 1 )) || true
  done
}
