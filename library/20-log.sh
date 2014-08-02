LOG() {
  local level="$1"
  shift

  case "${level}" in
    INFO|WARNING|ERROR|FATAL) :;;
    *) LOG FATAL "no such log level: ${level}"
  esac
  local datetime="$(date +'%m%d %T.%N')"
  # For systems not supporting %N in date.
  datetime="${datetime/.N/.000000}"
  local pid="$$"
  if php::isset __IMOSH_LOG_PID; then
    pid="${__IMOSH_LOG_PID}"
  fi
  local message=(
      "${level:0:1}${datetime}"
      "${pid}"
      "${BASH_SOURCE[1]}:${BASH_LINENO[0]}]"
      "$*")
  echo "${message[@]}" >&2
  if [ "${level}" == 'FATAL' ]; then
    imosh::stack_trace '*** Check failure stack trace: ***'
    exit 1
  fi
}
