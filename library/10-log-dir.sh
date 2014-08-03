__IMOSH_PROGRAM_NAME="${0##*/}"
__IMOSH_HOSTNAME="$(hostname -s)"
__IMOSH_USER="${USER}"
__IMOSH_LOG_PREFIX="${__IMOSH_PROGRAM_NAME}.${__IMOSH_HOSTNAME}.${__IMOSH_USER}"
__IMOSH_LOG_DIR="${TMPDIR:-/tmp}"
__IMOSH_LOG_SUFFIX="$(date +'%Y%m%d.%H%M%S').$$"

imosh::internal::log_dir() {
  local severity="${1}"
  local path=''
  path+="${__IMOSH_LOG_DIR}/"
  path+="${__IMOSH_LOG_PREFIX}.${severity}.${__IMOSH_LOG_SUFFIX}"
  print "${path}"
}

if [ -w "${__IMOSH_LOG_DIR}" ]; then
  exec 101>"$(imosh::internal::log_dir INFO)"
  exec 102>"$(imosh::internal::log_dir WARNING)"
  exec 103>"$(imosh::internal::log_dir ERROR)"
  exec 104>"$(imosh::internal::log_dir FATAL)"
else
  exec 101>/dev/null 102>/dev/null 103>/dev/null 104>/dev/null
  echo "failed to open files to write logs: ${__IMOSH_LOG_DIR}" >&2
fi
