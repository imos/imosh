imosh::internal::loglevel() {
  case "$1" in
    ALL)     echo 0;;
    INFO)    echo 1;;
    WARNING) echo 2;;
    ERROR)   echo 3;;
    FATAL)   echo 4;;
    NONE)    echo 5;;
    *)       LOG FATAL "unknown level: $1";;
  esac
}

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
  local pid
  if php::isset __IMOSH_LOG_PID; then
    pid="${__IMOSH_LOG_PID}"
  else
    imosh::set_pid
    pid="${IMOSH_PID}"
  fi
  local file="${BASH_SOURCE[1]##*/}"
  if [ "${file}" = '' ]; then file='-'; fi
  local message=(
      "${level:0:1}${datetime}"
      "${pid}"
      "${file}:${BASH_LINENO[0]}]"
      "$@")
  message="$(echo "${message[@]}")"
  if [ "$(imosh::internal::loglevel "${level}")" -ge \
       "$(imosh::internal::loglevel "${FLAGS_stacktrace_threshold}")" ]; then
    message+=$'\n'
    message+="$(imosh::stack_trace "*** LOG ${level} stack trace: ***" 2>&1)"
  fi
  local logtostderr=0
  if php::isset FLAGS_logtostderr; then
    logtostderr="${FLAGS_logtostderr}"
  fi
  local alsologtostderr=0
  if php::isset FLAGS_alsologtostderr; then
    alsologtostderr="${FLAGS_alsologtostderr}"
  fi
  case "${level}" in
    INFO)
      if (( logtostderr || alsologtostderr )); then
        echo "${message}" >&2
      fi
      if (( ! logtostderr )); then
        echo "${message}" >&101
      fi
      ;;
    WARNING)
      if (( logtostderr || alsologtostderr )); then
        echo "${message}" >&2
      fi
      if (( ! logtostderr )); then
        echo "${message}" >&101
        echo "${message}" >&102
      fi
      ;;
    ERROR)
      echo "${message}" >&2
      if (( ! logtostderr )); then
        echo "${message}" >&101
        echo "${message}" >&102
        echo "${message}" >&103
      fi
      ;;
    FATAL)
      echo "${message}" >&2
      if (( ! logtostderr )); then
        echo "${message}" >&101
        echo "${message}" >&102
        echo "${message}" >&103
        echo "${message}" >&104
      fi
      imosh::quiet_die 1
      ;;
  esac
}
