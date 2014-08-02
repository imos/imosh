# __IMOSH_FLAGS_TYPE_<flag name>=<flag type>
# __IMOSH_FLAGS_DESCRIPTION_<flag name>=<description>
# __IMOSH_FLAGS_ALIASES=(from:to ...)

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
    variant)
      print "${value}"
      ;;
    *) LOG FATAL "no such type: ${type}";;
  esac
}

imosh::internal::flag_type() {
  local name="$1"

  if [ "$#" -ne 1 ]; then
    LOG FATAL 'flag_type requires 1 arugument.'
  fi
  eval print '${__IMOSH_FLAGS_TYPE_'"${name}"'}'
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
    LOG FATAL "${type}'s default value should be ${type}: ${default_value}"
  fi
  default_value="$(imosh::internal::convert_type "${type}" "${default_value}")"
  local description="${description} (default: $(
                         imosh::shell_escape "${default_value}"))"
  if php::isset "__IMOSH_FLAGS_TYPE_${name}"; then
    LOG FATAL "already defined flag: ${name}"
  fi
  case "${type}" in
    int|bool) declare -i "FLAGS_${name}";;
  esac
  eval "FLAGS_${name}=$(imosh::shell_escape "${default_value}")"
  eval "__IMOSH_FLAGS_TYPE_${name}=${type}"
  eval "__IMOSH_FLAGS_DESCRIPTION_${name}=$(
            imosh::shell_escape "${description}")"
  if [ "${ARGS_alias}" != '' ]; then
    imosh::internal::define_flag \
        "${type}" "${ARGS_alias}" "${default_value}" "${description}"
    eval "__IMOSH_FLAGS_ALIASES+=( \
              $(imosh::shell_escape "${name}:${ARGS_alias}"))"
  fi
}

DEFINE_string() { imosh::internal::define_flag string "$@"; }
DEFINE_int() { imosh::internal::define_flag int "$@"; }
DEFINE_bool() { imosh::internal::define_flag bool "$@"; }
DEFINE_double() { imosh::internal::define_flag double "$@"; }

imosh::internal::init() {
  imosh::internal::parse_args flag "$@"
  if [ "${#IMOSH_ARGS[@]}" -ne 0 ]; then
    readonly "${IMOSH_ARGS[@]}"
  fi
  if [ "${#__IMOSH_FLAGS_ALIASES[@]}" -ne 0 ]; then
    for alias in "${__IMOSH_FLAGS_ALIASES[@]}"; do
      eval "FLAGS_${alias%%:*}=\"\${FLAGS_${alias#*:}}\""
    done
  fi
}

readonly IMOSH_INIT='
    set -e -u
    imosh::internal::init "$@"
    if [ "${#IMOSH_ARGV[@]}" -ne 0 ]; then
      set -- "${IMOSH_ARGV[@]}"
    fi'

__IMOSH_FLAGS_ALIASES=()