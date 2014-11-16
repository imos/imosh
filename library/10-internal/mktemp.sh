__imosh::mktemp() {
  TMPDIR="${TMPDIR:-/tmp}"
  TMPDIR="${TMPDIR%/}"
  export TMPDIR="${TMPDIR}/imosh.${RANDOM}.${RANDOM}.${RANDOM}.${RANDOM}"
  export IMOSH_TMPDIR="${TMPDIR}"
  export __IMOSH_CORE_TMPDIR="${TMPDIR}/.imosh"
  if ! mkdir -p "${__IMOSH_CORE_TMPDIR}"; then
    LOG FATAL "Failed to create a temporary directory: ${__IMOSH_CORE_TMPDIR}"
  fi
}
