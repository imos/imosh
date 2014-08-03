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
  datetime="${datetime:0:20}"
  local pid="$$"
  if php::isset __IMOSH_LOG_PID; then
    pid="${__IMOSH_LOG_PID}"
  fi
  local message=(
      "${level:0:1}${datetime}"
      "${pid}"
      "${BASH_SOURCE[1]##*/}:${BASH_LINENO[0]}]"
      "$*")
  message="${message[*]}"
  if [ "${level}" == 'FATAL' ]; then
    message+=$'\n'
    message+="$(imosh::stack_trace '*** Check failure stack trace: ***' 2>&1)"
  fi
  case "${level}" in
    INFO)
      echo "${message}" >&2
      echo "${message}" >&101
      ;;
    WARNING)
      echo "${message}" >&2
      echo "${message}" >&101
      echo "${message}" >&102
      ;;
    ERROR)
      echo "${message}" >&2
      echo "${message}" >&101
      echo "${message}" >&102
      echo "${message}" >&103
      ;;
    FATAL)
      echo "${message}" >&2
      echo "${message}" >&101
      echo "${message}" >&102
      echo "${message}" >&103
      echo "${message}" >&104
      exit 1
      ;;
  esac
}
