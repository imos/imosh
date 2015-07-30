# Parses arguments without getopt.
imosh::internal::parse_args() {
  local class_name="$1"; shift

  local upper_class_name="${class_name}"
  func::strtoupper upper_class_name
  local arg arg_name arg_value
  IMOSH_ARGV=()
  IMOSH_ARGS=()
  while [ "$#" != '0' ]; do
    if sub::isset IMOSH_PREDICATE &&
       [ "${upper_class_name}" = 'FLAG' ] &&
       [ "${#IMOSH_ARGV[*]}" -eq "${IMOSH_PREDICATE}" ]; then
      IMOSH_ARGV+=("$@")
      break
    fi
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
    # If the argument does not have "=", it should be a boolean flag or it
    # should consume its next argument.
    if [ "${arg_value:0:1}" = '=' ]; then
      arg_value="${arg_value:1}"
    # Preprocess for boolean flags (e.g. --name, --noname) and separated flags
    # (e.g. --name value).
    else
      # If it is a negative boolean flag (--noname).
      if [ "${arg_name:0:2}" = 'no' ] &&
         sub::isset "${upper_class_name}S_${arg_name:2}" &&
         ( [ "${class_name}" != 'flag' ] ||
           [ "$(imosh::internal::flag_type "${arg_name:2}")" = 'BOOL' ] ); then
        arg_name="${arg_name:2}"
        arg_value=0
      else
        if ! sub::isset "${upper_class_name}S_${arg_name}"; then
          LOG FATAL "no such bool ${class_name} is defined:" \
                    "(${upper_class_name}S_)${arg_name}"
        fi
        if [ "${class_name}" != 'flag' ] ||
           [ "$(imosh::internal::flag_type "${arg_name}")" = 'BOOL' ]; then
          arg_value=1
        else
          if [ "$#" -eq 0 ]; then
            LOG FATAL "the ${arg_name} flag requires a value"
          fi
          arg_value="${1}"
          shift
        fi
      fi
    fi
    if [ "${class_name}" = 'flag' ]; then
      local type="$(imosh::internal::flag_type "${arg_name}")"
      local single_type="${type}"
      if [ "${type:0:5}" = 'MULTI' ]; then
        single_type="${type:5}"
      fi
      if [ "${type}" = 'LIST' ]; then
        # TODO(imos): Support delimiter.
        func::explode arg_value ',' "${arg_value}"
      fi
      if [ "${single_type}" = 'ENUM' ]; then
        local __imosh_enum_values=()
        func::array_values \
            __imosh_enum_values "__IMOSH_FLAGS_ENUM_VALUES_${arg_name}"
      fi
      CHECK --message="FLAGS_${arg_name} is invalid: ${arg_value}" \
            func::cast arg_value "${single_type}"
      local is_default=0
      func::strcpy 'is_default' "__IMOSH_FLAGS_IS_DEFAULT_${arg_name}"
      func::let "__IMOSH_FLAGS_IS_DEFAULT_${arg_name}" '0'
      if [ "${type}" = 'LIST' ]; then
        # Set values here.  FLAGS_* are global variables, and this does not
        # cause scope issues.
        func::array_values "FLAGS_${arg_name}" arg_value
        continue
      fi
      if [ "${type:0:5}" = 'MULTI' ]; then
        if (( is_default )); then
          eval "FLAGS_${arg_name}=(\"\${arg_value}\")"
        else
          eval "FLAGS_${arg_name}+=(\"\${arg_value}\")"
        fi
        continue
      fi
    fi
    if ! sub::isset "${upper_class_name}S_${arg_name}"; then
      LOG FATAL "No such ${class_name} is defined: ${arg_name}"
    fi
    func::str_replace arg_value "'" "'\\''"
    IMOSH_ARGS+=("${upper_class_name}S_${arg_name}='${arg_value}'")
  done
}
