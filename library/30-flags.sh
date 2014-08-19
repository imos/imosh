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
  local type="$1"; shift

  local ARGS_alias='' ARGS_alias_flag=0
  eval "${IMOSH_PARSE_ARGUMENTS}"

  if [ "$#" -lt 3 ]; then
    LOG FATAL 'DEFINE_${type} requires 3+ arguments.'
  fi
  local name="$1"; shift
  local default_value="$1"; shift
  local description="$*"

  # Change the default value based on its corresponding environment variable.
  if php::isset "IMOSH_FLAGS_${name}"; then
    default_value="$(eval print "\${IMOSH_FLAGS_${name}}")"
  fi
  if ! imosh::internal::convert_type \
           "${type}" "${default_value}" >/dev/null; then
    LOG FATAL "${type}'s default value should be ${type}: ${default_value}"
  fi
  default_value="$(imosh::internal::convert_type "${type}" "${default_value}")"
  if php::isset "__IMOSH_FLAGS_TYPE_${name}"; then
    LOG FATAL "already defined flag: ${name}"
  fi
  eval "FLAGS_${name}=$(imosh::shell_escape "${default_value}")"
  eval "__IMOSH_FLAGS_TYPE_${name}=${type}"
  if [ "${ARGS_alias}" != '' ]; then
    imosh::internal::define_flag "${type}" --alias_flag \
        "${ARGS_alias}" "${default_value}" "${description}"
    eval "__IMOSH_FLAGS_ALIASES+=( \
              $(imosh::shell_escape "${name}:${ARGS_alias}"))"
  fi
  if (( ! ARGS_alias_flag )); then
    local escaped_default_value=''
    case "${type}" in
      int) escaped_default_value="${default_value}";;
      bool)
        if (( default_value )); then
          escaped_default_value='true'
        else
          escaped_default_value='false'
        fi
        ;;
      *) escaped_default_value="$(imosh::shell_escape "${default_value}")";;
    esac
    eval "__IMOSH_FLAGS_DEFAULT_${name}=$(
              imosh::shell_escape "--${name}=${escaped_default_value}")"
    if [ "${ARGS_alias}" != '' ]; then
      description+=" (Alias: --${ARGS_alias})"
    fi
    eval "__IMOSH_FLAGS_DESCRIPTION_${name}=$(
              imosh::shell_escape "${description}")"
    __IMOSH_FLAGS+=("${name}")
  fi
}

DEFINE_string() { imosh::internal::define_flag string "$@"; }
DEFINE_int() { imosh::internal::define_flag int "$@"; }
DEFINE_bool() { imosh::internal::define_flag bool "$@"; }
DEFINE_double() { imosh::internal::define_flag double "$@"; }

imosh::internal::get_main_script() {
  local depth="${#BASH_SOURCE[@]}"
  local main_script="${BASH_SOURCE[$((depth-1))]}"
  echo "${main_script}"
}

imosh::internal::get_usage() {
  local file="${1}"
  grep --max-count=1 -B 1000 -v '^#' "${file}" | grep '^#' | while read line; do
    case "${line}" in
      '#!'*) continue;;
      '# '*) echo "${line:2}";;
      '#'*) echo "${line:1}";;
    esac
  done > "${__IMOSH_CORE_TMPDIR}/usage"
  if [ -s "${__IMOSH_CORE_TMPDIR}/usage" ]; then
    cat "${__IMOSH_CORE_TMPDIR}/usage"
  else
    echo 'No description.'
  fi
}

imosh::internal::man() {
  echo ".TH ${0##*/} 1"; echo
  echo '.SH SYNOPSIS'
  echo ".B ${0##*/}"; echo '[\fIOPTIONS\fP] [\fIargs...\fP]'; echo

  echo '.SH DESCRIPTION'
  imosh::internal::get_usage "$(imosh::internal::get_main_script)"

  echo '.SH OPTIONS';
  for flag_name in "${__IMOSH_FLAGS[@]}"; do
    echo '.TP'
    echo -n '\fB'
    eval "echo -n \"\${__IMOSH_FLAGS_DEFAULT_${flag_name}}\""
    echo '\fP'
    eval "echo \"\${__IMOSH_FLAGS_DESCRIPTION_${flag_name}}\""
    echo
  done
}

imosh::internal::help() {
  echo "Usage: ${0##*/} [options...] [args...]"
  echo
  echo 'Description:'
  imosh::internal::get_usage "$(imosh::internal::get_main_script)" | \
      while read line; do
    echo "  ${line}"
  done
  echo
  echo "Options:"
  for flag_name in "${__IMOSH_FLAGS[@]}"; do
    eval "echo -n \"  \${__IMOSH_FLAGS_DEFAULT_${flag_name}}:\""
    eval "echo \" \${__IMOSH_FLAGS_DESCRIPTION_${flag_name}}\""
  done
}

imosh::internal::init() {
  imosh::internal::parse_args flag "$@"
  if [ "${#IMOSH_ARGS[@]}" -ne 0 ]; then
    eval "${IMOSH_ARGS[@]}"
  fi
  if [ "${#__IMOSH_FLAGS_ALIASES[@]}" -ne 0 ]; then
    for alias in "${__IMOSH_FLAGS_ALIASES[@]}"; do
      eval "FLAGS_${alias%%:*}=\"\${FLAGS_${alias#*:}}\""
      unset "FLAGS_${alias#*:}"
    done
  fi
  if [ "${#IMOSH_ARGS[@]}" -ne 0 ]; then
    readonly "${IMOSH_ARGS[@]}"
  fi
  if (( FLAGS_help )); then
    if [ -t 1 ]; then
      local man_file="${__IMOSH_CORE_TMPDIR}/man"
      imosh::internal::man >"${man_file}"
      man "${man_file}"
    else
      imosh::internal::help >&2
    fi
    exit 0
  fi
}

readonly IMOSH_INIT='
    set -e -u
    imosh::internal::init "$@"
    if [ "${#IMOSH_ARGV[@]}" -ne 0 ]; then
      set -- "${IMOSH_ARGV[@]}"
    fi'

__IMOSH_FLAGS=()
__IMOSH_FLAGS_ALIASES=()

DEFINE_bool --alias=h help false 'Print this help message and exit.'
DEFINE_bool 'alsologtostderr' false \
            'Log messages go to stderr in addition to logfiles.'
DEFINE_bool 'logtostderr' false \
            'Log messages go to stderr instead of logfiles.'
