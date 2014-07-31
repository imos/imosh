# Parses arguments without getopt.
imosh::internal::parse_flags() {
  local flag flag_name flag_value
  IMOSH_ARGV=()
  IMOSH_FLAGS=()
  while [ "$#" != '0' ]; do
    local flag="$1"
    shift
    if [ "${flag:0:1}" != '-' ]; then
      IMOSH_ARGV+=("$flag")
      continue
    fi
    if [ "${flag}" == '--' ]; then
      IMOSH_ARGV+=("$@")
    fi
    case "${flag}" in
      --*) flag="${flag:2}";;
      -*) flag="${flag:1}";;
    esac
    flag_name="$(cut -d= -f1 <<< "${flags}")"
    flag_value="${flag:${#flag_name}}"
    if [ "${flag_value:0:1}" != '=' ]; then
      IMOSH_FLAGS+=("FLAGS_${flag_name}=1")
      if [ "${flag_name:0:2}" == 'no' ]; then
        IMOSH_FLAGS+=("FLAGS_${flag_name:2}=0")
      fi
      continue
    fi
    IMOSH_FLAGS+=("FLAGS_${flag_name}=$(imosh::shell_escape "${flag_value:1}")")
  done
}

alias imosh::parse_arguments='
    local IMOSH_ARGV IMOSH_FLAGS
    imosh::internal::parse_flags "$@"
    local "${IMOSH_FLAGS[@]}"
    set -- "${IMOSH_ARGV}'

