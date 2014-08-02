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

DEFINE_variable() {
  local type="$1"
  local name="$2"
  local default_value="$3"
  local description="$4"

  local ARGS_alias
  eval "${IMOSH_PARSE_ARGUMENTS}"
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

DEFINE_string() { DEFINE_variable string "$@"; }
DEFINE_int() { DEFINE_variable int "$@"; }
DEFINE_bool() { DEFINE_variable bool "$@"; }
DEFINE_double() { DEFINE_variable double "$@"; }
