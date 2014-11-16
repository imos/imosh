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
  if sub::isset __IMOSH_LOG_PID; then
    pid="${__IMOSH_LOG_PID}"
  else
    func::getmypid pid
  fi
  local file="${BASH_SOURCE[1]##*/}"
  if [ "${file}" = '' ]; then file='-'; fi
  local message=(
      "${level:0:1}${datetime}"
      "${pid}"
      "${file}:${BASH_LINENO[0]}]"
      "$@")
  IFS=' ' eval 'message="${message[*]}"'
  if ! sub::isset FLAGS_stacktrace_threshold || \
     [ "${FLAGS_stacktrace_threshold}" = '' ]; then
    FLAGS_stacktrace_threshold='ERROR'
  fi
  if [ "$(imosh::internal::loglevel "${level}")" -ge \
       "$(imosh::internal::loglevel "${FLAGS_stacktrace_threshold}")" ]; then
    message+=$'\n'
    message+="$(imosh::stack_trace "*** LOG ${level} stack trace: ***" 2>&1)"
  fi
  local logtostderr=0
  if sub::isset FLAGS_logtostderr; then
    logtostderr="${FLAGS_logtostderr}"
  fi
  local alsologtostderr=0
  if sub::isset FLAGS_alsologtostderr; then
    alsologtostderr="${FLAGS_alsologtostderr}"
  fi
  case "${level}" in
    INFO)
      if (( logtostderr || alsologtostderr )); then
        echo "${message}" >&105
      fi
      if (( ! logtostderr )); then
        echo "${message}" >&101
      fi
      ;;
    WARNING)
      if (( logtostderr || alsologtostderr )); then
        echo "${message}" >&105
      fi
      if (( ! logtostderr )); then
        echo "${message}" >&101
        echo "${message}" >&102
      fi
      ;;
    ERROR)
      echo "${message}" >&105
      if (( ! logtostderr )); then
        echo "${message}" >&101
        echo "${message}" >&102
        echo "${message}" >&103
      fi
      ;;
    FATAL)
      echo "${message}" >&105
      if (( ! logtostderr )); then
        echo "${message}" >&101
        echo "${message}" >&102
        echo "${message}" >&103
        echo "${message}" >&104
      fi
      sub::exit 1
      ;;
  esac
}

imosh::internal::log_file() {
  sub::println \
      "${FLAGS_log_dir}/${__IMOSH_LOG_PREFIX}.${1}.${__IMOSH_LOG_SUFFIX}"
}

imosh::internal::init_log() {
  # Close descriptors for logs beforehand for BASH3's bug.
  exec 101>&- 102>&- 103>&- 104>&-
  if [ "${FLAGS_log_dir}" != '' -a -w "${FLAGS_log_dir}" ]; then
    __IMOSH_LOG_PREFIX="${0##*/}.$(hostname -s).$(whoami)"
    __IMOSH_LOG_SUFFIX="$(date +'%Y%m%d.%H%M%S').$$"
    exec 101>"$(imosh::internal::log_file INFO)"
    exec 102>"$(imosh::internal::log_file WARNING)"
    exec 103>"$(imosh::internal::log_file ERROR)"
    exec 104>"$(imosh::internal::log_file FATAL)"
    return
  fi
  exec 101>/dev/null 102>/dev/null 103>/dev/null 104>/dev/null
  if [ "${FLAGS_log_dir}" == '' ]; then
    return
  fi
  LOG ERROR "failed to open files to write logs: ${__IMOSH_LOG_DIR}"
}
