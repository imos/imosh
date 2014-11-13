readonly IMOSH_PARSE_ARGUMENTS='
    local IMOSH_ARGV IMOSH_ARGS
    imosh::internal::parse_args arg "$@"
    if [ "${#IMOSH_ARGS[*]}" -ne 0 ]; then
      readonly "${IMOSH_ARGS[@]}"
    fi
    if [ "${#IMOSH_ARGV[*]}" -ne 0 ]; then
      set -- "${IMOSH_ARGV[@]}"
    else
      set --
    fi'

readonly IMOSH_WRONG_NUMBER_OF_ARGUMENTS='
    LOG ERROR "Wrong number of arguments: $#"
    return 1'

readonly IMOSH_INIT='
    set -e -u
    imosh::internal::init "$@"
    if [ "${#IMOSH_ARGV[*]}" -ne 0 ]; then
      set -- "${IMOSH_ARGV[@]}"
    else
      set --
    fi'

__IMOSH_FLAGS=()
__IMOSH_FLAGS_ALIASES=()
