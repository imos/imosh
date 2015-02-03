# __IMOSH_FLAGS_TYPE_<flag name>=<flag type>
# __IMOSH_FLAGS_DESCRIPTION_<flag name>=<description>
# __IMOSH_FLAGS_GROUP_<flag name>=<group>
# __IMOSH_FLAGS_ALIASES=(from:to ...)
# __IMOSH_FLAGS_IS_DEFAULT_<flag name>=<is default>

imosh::internal::flag_type() {
  local name="$1"

  if [ "$#" -ne 1 ]; then
    LOG FATAL 'flag_type requires 1 arugument.'
  fi
  eval "sub::print \"\${__IMOSH_FLAGS_TYPE_${name}}\""
}

imosh::internal::define_flag() {
  local type="$1"; shift

  local ARGS_alias='' ARGS_alias_flag=0 ARGS_group='main'
  eval "${IMOSH_PARSE_ARGUMENTS}"

  if [ "$#" -lt 3 ]; then
    LOG FATAL 'DEFINE_${type} requires 3+ arguments.'
  fi
  local name="$1"; shift
  local default_value="$1"; shift
  local original_default_value="${default_value}"
  local description="$*"
  local group="${ARGS_group}"
  func::strtoupper group

  # Change the default value based on its corresponding environment variable.
  if sub::isset "IMOSH_FLAGS_${name}"; then
    func::strcpy default_value "IMOSH_FLAGS_${name}"
  fi
  if [ "${type}" = 'LIST' -o "${type:0:5}" = 'MULTI' ]; then
    if [ "${default_value}" = '' ]; then
      default_value=()
    else
      func::explode default_value ',' "${default_value}"
    fi
  fi
  CHECK \
      --message="${name}'s default value is invalid: ${original_default_value}." \
      func::cast default_value "${type}"
  if sub::isset "__IMOSH_FLAGS_TYPE_${name}"; then
    LOG FATAL "already defined flag: ${name}"
  fi
  if [ "${type}" = 'LIST' -o "${type:0:5}" = 'MULTI' ]; then
    func::array_values "FLAGS_${name}" 'default_value'
  else
    func::strcpy "FLAGS_${name}" 'default_value'
  fi
  func::strcpy "__IMOSH_FLAGS_TYPE_${name}" 'type'
  func::let "__IMOSH_FLAGS_IS_DEFAULT_${name}" '1'
  if [ "${ARGS_alias}" != '' ]; then
    imosh::internal::define_flag "${type}" --alias_flag \
        "${ARGS_alias}" "${original_default_value}" "${description}"
    __IMOSH_FLAGS_ALIASES+=("${name}:${ARGS_alias}")
  fi
  if (( ! ARGS_alias_flag )); then
    local escaped_default_value=''
    case "${type}" in
      'INT') escaped_default_value="${default_value}";;
      'BOOL')
        if (( default_value )); then
          escaped_default_value='true'
        else
          escaped_default_value='false'
        fi
        ;;
      *)
        escaped_default_value="${original_default_value}"
        func::escapeshellarg escaped_default_value
        ;;
    esac
    func::let "__IMOSH_FLAGS_DEFAULT_${name}" \
              "--${name}=${escaped_default_value}"
    if [ "${ARGS_alias}" != '' ]; then
      description+=" (Alias: --${ARGS_alias})"
    fi
    func::let "__IMOSH_FLAGS_DESCRIPTION_${name}" "${description}"
    if [ "${group}" != 'IMOSH' -a "${group}" != 'MAIN' ]; then
      func::let "__IMOSH_FLAGS_GROUP_${name}" "${group}"
    fi
    __IMOSH_FLAGS+=("${group}:${name}")
  fi
}

DEFINE_string() { imosh::internal::define_flag STRING "$@"; }
DEFINE_int() { imosh::internal::define_flag INT "$@"; }
DEFINE_bool() { imosh::internal::define_flag BOOL "$@"; }
DEFINE_double() { imosh::internal::define_flag DOUBLE "$@"; }
DEFINE_multistring() { imosh::internal::define_flag MULTISTRING "$@"; }
DEFINE_multiint() { imosh::internal::define_flag MULTIINT "$@"; }
DEFINE_multibool() { imosh::internal::define_flag MULTIBOOL "$@"; }
DEFINE_multidouble() { imosh::internal::define_flag MULTIDOUBLE "$@"; }
DEFINE_list() { imosh::internal::define_flag LIST "$@"; }

imosh::internal::get_main_script() {
  local depth="${#BASH_SOURCE[*]}"
  local main_script="${BASH_SOURCE[$((depth-1))]}"
  echo "${main_script}"
}

imosh::internal::get_usage() {
  local file="${1}"
  while IFS='' read -r line; do
    case "${line}" in
      '#!'*) continue;;
      '# '*) echo "${line:2}";;
      '#'*)  echo "${line:1}";;
      *)     break;;
    esac
  done < "${file}" > "${__IMOSH_CORE_TMPDIR}/usage"
  if [ -s "${__IMOSH_CORE_TMPDIR}/usage" ]; then
    cat "${__IMOSH_CORE_TMPDIR}/usage"
  else
    echo 'No description.'
  fi
}

imosh::internal::flag_groups() {
  local groups=()
  local group=''
  local main_group_exists=0
  local imosh_group_exists=0
  for flag_name in "${__IMOSH_FLAGS[@]}"; do
    local parts=()
    func::explode parts ':' "${flag_name}"
    group="${parts[0]}"
    local lower_group="${group}"
    func::strtolower lower_group
    if [ "${lower_group}" == 'main' ]; then
      main_group_exists=1
    elif [ "${lower_group}" == 'imosh' ]; then
      imosh_group_exists=1
    else
      groups+=("${group}")
    fi
  done
  if (( main_group_exists )); then
    echo 'main'
  fi
  if [ "${#groups[*]}" -ne 0 ]; then
    func::array_unique groups
    for group in "${groups[@]}"; do
      echo "${group}"
    done
  fi
  if (( imosh_group_exists && FLAGS_helpfull )); then
    echo 'imosh'
  fi
}

imosh::internal::group_flags() {
  local group="$1"
  local lower_group="${group}"
  func::strtolower lower_group

  local flags=()
  for flag_name in "${__IMOSH_FLAGS[@]}"; do
    local parts=()
    func::explode parts ':' "${flag_name}"
    local lower_part="${parts[0]}"
    func::strtolower lower_part
    if [ "${lower_group}" != "${lower_part}" ]; then
      continue
    fi
    flags+=("${parts[1]}")
  done
  func::sort flags
  for flag in "${flags[@]}"; do
    echo "${flag}"
  done
}

imosh::internal::man() {
  echo ".TH ${0##*/} 1"; echo
  echo '.SH DESCRIPTION'
  sub::usage --format=groff --notitle \
      "$(imosh::internal::get_main_script)"

  echo '.SH OPTIONS'
  for flag_group in $(imosh::internal::flag_groups); do
    local upper_flag_group="${flag_group}"
    func::strtoupper upper_flag_group
    echo ".SS ${upper_flag_group} OPTIONS"
    for flag_name in $(imosh::internal::group_flags "${flag_group}"); do
      echo '.TP'
      echo -n '\fB'
      eval "echo -n \"\${__IMOSH_FLAGS_DEFAULT_${flag_name}}\""
      echo '\fP'
      eval "echo \"\${__IMOSH_FLAGS_DESCRIPTION_${flag_name}}\""
      echo
    done
  done
}

imosh::internal::help() {
  sub::usage --format=text --notitle \
      "$(imosh::internal::get_main_script)"
  echo "OPTIONS:"
  for flag_group in $(imosh::internal::flag_groups); do
    local upper_flag_group="${flag_group}"
    func::strtoupper upper_flag_group
    echo "  ${upper_flag_group} OPTIONS:"
    for flag_name in $(imosh::internal::group_flags "${flag_group}"); do
      eval "echo \"    \${__IMOSH_FLAGS_DEFAULT_${flag_name}}\""
      eval "echo \"\${__IMOSH_FLAGS_DESCRIPTION_${flag_name}}\"" | \
          fold -s -w 70 | while IFS= read -r line; do
        sub::println "        ${line}"
      done
    done
  done
}

__imosh::help_markdown() {
  sub::usage --format=markdown --notitle \
      "$(imosh::internal::get_main_script)"
  echo "# Options"
  for flag_group in $(imosh::internal::flag_groups); do
    local upper_flag_group="${flag_group}"
    func::strtoupper upper_flag_group
    echo "## ${flag_group} options"
    for flag_name in $(imosh::internal::group_flags "${flag_group}"); do
      eval "echo \"* \${__IMOSH_FLAGS_DEFAULT_${flag_name}}\""
      eval "echo \"    * \${__IMOSH_FLAGS_DESCRIPTION_${flag_name}}\""
    done
  done
}

__imosh::help() {
  case "${FLAGS_help_format}" in
    groff)
      imosh::internal::man;;
    markdown)
      __imosh::help_markdown;;
    *)
      imosh::internal::help;;
  esac
}

imosh::internal::init() {
  imosh::internal::parse_args flag "$@"
  if [ "${#IMOSH_ARGS[*]}" -ne 0 ]; then
    eval "${IMOSH_ARGS[@]}"
  fi
  imosh::logging::init
  if [ "${#__IMOSH_FLAGS_ALIASES[*]}" -ne 0 ]; then
    for alias in "${__IMOSH_FLAGS_ALIASES[@]}"; do
      eval "FLAGS_${alias%%:*}=\"\${FLAGS_${alias#*:}}\""
      unset "FLAGS_${alias#*:}"
    done
  fi
  # Re-assign flag values so as to support flag aliases.
  if [ "${#IMOSH_ARGS[*]}" -ne 0 ]; then
    eval "${IMOSH_ARGS[@]}"
  fi
  if (( FLAGS_help || FLAGS_helpfull )) ||
     [ "${FLAGS_help_format}" != '' ]; then
    imosh::help
    exit 0
  fi
}

# imosh::help -- Shows help message.
#
# This shows a help message as --help flag does.
#
# Usage:
#   void imosh::help()
imosh::help() {
  if [ "$#" -eq 0 ]; then
    if [ "${FLAGS_help_format}" = '' ]; then
      if [ -t 1 ]; then
        FLAGS_help_format='groff'
      else
        FLAGS_help_format='text'
      fi
    fi
    if [ -t 1 -a "${FLAGS_help_format}" = 'groff' ]; then
      local man_file="${__IMOSH_CORE_TMPDIR}/man"
      __imosh::help >"${man_file}"
      man "${man_file}"
    else
      __imosh::help >&2
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
