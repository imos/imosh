__IMOSH_PROGRAM_NAME="${0##*/}"
__IMOSH_HOSTNAME="$(hostname -s)"
__IMOSH_USER="$(whoami)"
__IMOSH_LOG_PREFIX="${__IMOSH_PROGRAM_NAME}.${__IMOSH_HOSTNAME}.${__IMOSH_USER}"
__IMOSH_LOG_SUFFIX="$(date +'%Y%m%d.%H%M%S').$$"

imosh::internal::log_file() {
  local severity="${1}"
  local path=''
  if [ "${FLAGS_log_dir}" == '' ]; then
    return
  fi
  path+="${FLAGS_log_dir}/"
  path+="${__IMOSH_LOG_PREFIX}.${severity}.${__IMOSH_LOG_SUFFIX}"
  print "${path}"
}

imosh::internal::init_log() {
  # Close descriptors for logs beforehand for BASH3's bug.
  exec 101>&- 102>&- 103>&- 104>&-
  if [ "${FLAGS_log_dir}" != '' -a -w "${FLAGS_log_dir}" ]; then
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

# Close descriptors for logs beforehand for BASH3's bug.
exec 101>&- 102>&- 103>&- 104>&-
# Open descriptors for LOG without calling init_log.
exec 101>/dev/null 102>/dev/null 103>/dev/null 104>/dev/null
