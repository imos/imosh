# Parses arguments without getopt.
imosh::internal::parse_args() {
  local arg arg_name arg_value
  IMOSH_ARGV=()
  IMOSH_ARGS=()
  while [ "$#" != '0' ]; do
    local arg="$1"
    shift
    if [ "${arg:0:1}" != '-' ]; then
      IMOSH_ARGV+=("$arg")
      continue
    fi
    if [ "${arg}" == '--' ]; then
      IMOSH_ARGV+=("$@")
    fi
    case "${arg}" in
      --*) arg="${arg:2}";;
      -*) arg="${arg:1}";;
    esac
    arg_name="${arg%%=*}"
    if [[ ! "${arg_name}" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
      LOG FATAL "arg name is bad: ${arg_name}"
    fi
    arg_value="${arg:${#arg_name}}"
    if [ "${arg_value:0:1}" != '=' ]; then
      if [ "${arg_name:0:2}" == 'no' ]; then
        if php::isset "ARGS_${arg_name:2}"; then
          IMOSH_ARGS+=("ARGS_${arg_name:2}=0")
          continue
        fi
      fi
      if php::isset "ARGS_${arg_name}"; then
        IMOSH_ARGS+=("ARGS_${arg_name}=1")
        continue
      fi
      LOG FATAL "no such arg is defined: ${arg_name}"
    fi
    if php::isset "ARGS_${arg_name}"; then
      IMOSH_ARGS+=("ARGS_${arg_name}=${arg_value:1}")
      continue
    fi
    LOG FATAL "no such arg is defined: ${arg_name}"
  done
}

readonly IMOSH_PARSE_ARGUMENTS='
    local IMOSH_ARGV IMOSH_ARGS
    imosh::internal::parse_args "$@"
    readonly "${IMOSH_ARGS[@]}"
    set -- "${IMOSH_ARGV}"'
