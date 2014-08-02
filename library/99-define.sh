# __IMOSH_FLAGS_TYPE_<flag name>=<flag type>
# __IMOSH_FLAGS_DESCRIPTION_<flag name>=<description>

imosh::internal::convert_type() {
  local type="$1"; shift
  local value="$*"

  case "${type}" in
    int)
      if [[ "${value}" =~ ^-?[0-9]+$ ]]; then
        print "${value}"
      else
        return 1
      fi
      ;;
    string)
      print "${value}"
      ;;
    bool)
      case "${value}" in
        1|T|t|[Tt]rue) print 1;;
        0|F|f|[Ff]alse) print 0;;
        *) return 1;;
      esac
      ;;
    *) LOG FATAL "no such type: ${type}";;
  esac
}

imosh::internal::define_flag() {
  local ARGS_alias
  eval "${IMOSH_PARSE_ARGUMENTS}"
  local type="$1"
  local name="$2"
  local default_value="$3"
  local description="$4"

  if [ "$#" -ne 4 ]; then
    LOG FATAL 'DEFINE_${type} requires 3 arguments.'
  fi
  if ! imosh::internal::convert_type \
           "${type}" "${default_value}" >/dev/null; then
    LOG FATAL "${1}'s default value should be ${type}: ${default_value}"
  fi
  default_value="$(imosh::internal::convert_type "${type}" "${default_value}")"
  local description="${description} (default: $(
                         imosh::shell_escape "${default_value}"))"
  if php::isset "__IMOSH_FLAGS_TYPE_${name}"; then
    LOG FATAL "already defined flag: ${name}"
  fi
  eval "FLAGS_${name}=$(imosh::shell_escape "${default_value}")"
  eval "__IMOSH_FLAGS_TYPE_${name}=${type}"
  eval "__IMOSH_FLAGS_DESCRIPTION_${name}=$(
            imosh::shell_escape "${description}")"
}

DEFINE_string() { imosh::internal::define_flag string "$@"; }
DEFINE_int() { imosh::internal::define_flag int "$@"; }
DEFINE_bool() { imosh::internal::define_flag bool "$@"; }
DEFINE_double() { imosh::internal::define_flag double "$@"; }

imosh::internal::init() {
  local flag flag_name flag_value
  IMOSH_ARGV=()
  while [ "$#" != '0' ]; do
    local flag="$1"
    shift
    if [ "${flag:0:1}" != '-' ]; then
      IMOSH_ARGV+=("${flag}")
      continue
    fi
    if [ "${flag}" == '--' ]; then
      IMOSH_ARGV+=("$@")
    fi
    case "${flag}" in
      --*) flag="${flag:2}";;
      -*) flag="${flag:1}";;
    esac
    flag_name="${flag%%=*}"
    if [[ ! "${flag_name}" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
      LOG FATAL "flag name is bad: ${flag_name}"
    fi
    flag_value="${flag:${#flag_name}}"
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

readonly IMOSH_INIT='
    imosh::internal::init "$@"
    set -- "${IMOSH_ARGV[@]}"'
