# Parses arguments without getopt.
imosh::internal::parse_args() {
  local class_name="$1"; shift

  local upper_class_name="$(php::strtoupper "${class_name}")"
  local arg arg_name arg_value
  IMOSH_ARGV=()
  IMOSH_ARGS=()
  while [ "$#" != '0' ]; do
    local arg="$1"
    shift
    if [ "${arg:0:1}" != '-' ]; then
      IMOSH_ARGV+=("${arg}")
      continue
    fi
    if [[ "${arg}" =~ ^-[0-9] ]]; then
      IMOSH_ARGV+=("${arg}")
      continue
    fi
    if [ "${arg}" = '--' ]; then
      IMOSH_ARGV+=("$@")
      break
    fi
    case "${arg}" in
      --*) arg="${arg:2}";;
      -*) arg="${arg:1}";;
    esac
    arg_name="${arg%%=*}"
    if [[ ! "${arg_name}" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
      LOG FATAL "${class_name} name is bad: ${arg_name}"
    fi
    arg_value="${arg:${#arg_name}}"
    if [ "${arg_value:0:1}" != '=' ]; then
      if [ "${arg_name:0:2}" = 'no' ]; then
        if php::isset "${upper_class_name}S_${arg_name:2}"; then
          if [ "${class_name}" != 'flag' ] || \
             [ "$(imosh::internal::flag_type "${arg_name:2}")" = 'bool' ]; then
            IMOSH_ARGS+=("${upper_class_name}S_${arg_name:2}=0")
            continue
          fi
        fi
      fi
      if php::isset "${upper_class_name}S_${arg_name}"; then
        if [ "${class_name}" != 'flag' ] ||
           [ "$(imosh::internal::flag_type "${arg_name}")" = 'bool' ]; then
          IMOSH_ARGS+=("${upper_class_name}S_${arg_name}=1")
          continue
        fi
      fi
      if ! php::isset "${upper_class_name}S_${arg_name}"; then
        LOG FATAL "no such bool ${class_name} is defined:" \
                  "(${upper_class_name}S_)${arg_name}"
      fi
      if [ "$#" -eq 0 ]; then
        LOG FATAL "the ${arg_name} flag requires a value"
      fi
      arg_value="=${1}"
      shift
    fi
    arg_value="${arg_value:1}"
    if php::isset "${upper_class_name}S_${arg_name}"; then
      if [ "${class_name}" = 'flag' ]; then
        if ! imosh::internal::convert_type \
               "$(imosh::internal::flag_type "${arg_name}")" \
               "${arg_value}" >/dev/null; then
          LOG FATAL "the ${arg_name} flag has an invalid value: ${arg_value}"
        else
          arg_value="$(imosh::internal::convert_type \
                             "$(imosh::internal::flag_type "${arg_name}")" \
                             "${arg_value}")"
        fi
      fi
      IMOSH_ARGS+=("${upper_class_name}S_${arg_name}=${arg_value}")
      continue
    fi
    LOG FATAL "no such ${class_name} is defined:" \
              "(${upper_class_name}S_)${arg_name}"
  done
}

readonly IMOSH_PARSE_ARGUMENTS='
    local IMOSH_ARGV IMOSH_ARGS
    imosh::internal::parse_args arg "$@"
    if [ "${#IMOSH_ARGS[@]}" -ne 0 ]; then
      readonly "${IMOSH_ARGS[@]}"
    fi
    if [ "${#IMOSH_ARGV[@]}" -ne 0 ]; then
      set -- "${IMOSH_ARGV[@]}"
    fi'
