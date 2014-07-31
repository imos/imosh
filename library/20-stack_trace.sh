# Shows a stack trace.  Arguments are used as a message.
imosh::stack_trace() {
  local max_depth="${#BASH_LINENO[@]}"
  local i=0
  if [ "$*" == '' ]; then
    echo 'imosh::stack_trace is called' >&2
  else
    echo "$*" >&2
  fi
  while (( i < max_depth - 1 )); do
    local lineno="${BASH_LINENO[$((i))]}"
    local file="${BASH_SOURCE[$((i+1))]}"
    local function="${FUNCNAME[$((i+1))]}"
    echo "  at ${function} (${file}:${lineno})" >&2
    ((i+=1))
  done
}

