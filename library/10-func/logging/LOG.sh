# LOG - Logs a message.
#
# LOG logs a message with a timestamp, the current process ID and a file
# position.
#
# Usage:
#     void LOG(string log_level, string message...)
LOG() {
  if [ "$#" -ge 2 ]; then
    local log_level="${1}"; shift
    local log_level_id=0
    func::log_level log_level_id "${log_level}"
    if (( log_level_id < 1 || 4 < log_level_id )); then
      LOG FATAL "Invalid log_level for LOG: ${log_level}(${log_level_id})"
    fi
    # Do not use FLAGS_* variables directly because LOG may be called before
    # flag initialization.
    local logtostderr=0
    if sub::isset FLAGS_logtostderr; then
      logtostderr="${FLAGS_logtostderr}"
    fi
    local alsologtostderr=0
    if sub::isset FLAGS_alsologtostderr; then
      alsologtostderr="${FLAGS_alsologtostderr}"
    fi
    # Speed up by skipping message generation if it is not necessary.
    if ! sub::isset __IMOSH_LOGGING &&
       (( log_level_id < 3 && logtostderr == 0 && alsologtostderr == 0 )); then
      return
    fi
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
    local message_parameters=(
        "${log_level:0:1}${datetime}"
        "${pid}"
        "${file}:${BASH_LINENO[0]}]"
        "$@")
    IFS=' ' eval 'local message="${message_parameters[*]}"'
    local stacktrace_thoreshold=4
    if sub::isset FLAGS_stacktrace_threshold; then
      func::log_level __IMOSH_LOGGING_STACKTRACE \
                      "${FLAGS_stacktrace_threshold}"
    fi
    if (( stacktrace_thoreshold <= log_level_id )); then
      message+=$'\n'
      message+="$(
          imosh::stack_trace "*** LOG ${log_level} stack trace ***" 2>&1)"
    fi
    case "${log_level}" in
      'INFO')
        if (( logtostderr || alsologtostderr )); then
          echo "${message}" >&105
        fi
        if (( ! logtostderr )); then
          echo "${message}" >&101
        fi
        ;;
      'WARNING')
        if (( logtostderr || alsologtostderr )); then
          echo "${message}" >&105
        fi
        if (( ! logtostderr )); then
          echo "${message}" >&101
          echo "${message}" >&102
        fi
        ;;
      'ERROR')
        echo "${message}" >&105
        if (( ! logtostderr )); then
          echo "${message}" >&101
          echo "${message}" >&102
          echo "${message}" >&103
        fi
        ;;
      'FATAL')
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
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

func::log_level() {
  if [ "$#" -eq 2 ]; then
    case "${2}" in
      'ALL')     func::let "${1}" 0;;
      'INFO')    func::let "${1}" 1;;
      'WARNING') func::let "${1}" 2;;
      'ERROR')   func::let "${1}" 3;;
      'FATAL')   func::let "${1}" 4;;
      'NONE')    func::let "${1}" 5;;
      *)         LOG FATAL "Unknown log level: ${2}";;
    esac
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

__imosh::logging::open() {
  if [ "$#" -eq 2 ]; then
    local target="${FLAGS_log_dir}/${__IMOSH_LOG_PREFIX}.${1}.${__IMOSH_LOG_SUFFIX}"
    eval "exec ${2}> \"\${target}\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

imosh::logging::init() {
  if [ "$#" -eq 0 ]; then
    # Close descriptors for logs beforehand for BASH3's bug.
    exec 101>&- 102>&- 103>&- 104>&-
    if [ "${FLAGS_log_dir}" != '' ]; then
      if [ -w "${FLAGS_log_dir}" ]; then
        __IMOSH_LOG_PREFIX="${0##*/}.$(hostname -s).$(whoami)"
        __IMOSH_LOG_SUFFIX="$(date +'%Y%m%d.%H%M%S').$$"
        __imosh::logging::open INFO    101
        __imosh::logging::open WARNING 102
        __imosh::logging::open ERROR   103
        __imosh::logging::open FATAL   104
        __IMOSH_LOGGING=1
        return
      else
        LOG ERROR "Failed to open files to write logs: ${FLAGS_log_dir}"
      fi
    fi
    exec 101> '/dev/null' 102> '/dev/null' 103> '/dev/null' 104> '/dev/null'
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
