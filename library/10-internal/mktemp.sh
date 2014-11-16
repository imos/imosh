__imosh::mktemp() {
  TMPDIR="${TMPDIR:-/tmp}"
  TMPDIR="${TMPDIR%/}"
  export TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/imosh.XXXXXX")"
  if [ "${TMPDIR}" = '' -o "${TMPDIR}" = '/' ]; then
    LOG FATAL 'failed to create a temporary directory.'
  fi

  export __IMOSH_CORE_TMPDIR="${TMPDIR}/.imosh"
  mkdir "${__IMOSH_CORE_TMPDIR}"
  local tmpdir="${TMPDIR}"
  func::escapeshellarg tmpdir
  sub::atexit "rm -rf ${tmpdir}"

  # For backward compatibility.
  export IMOSH_TMPDIR="${TMPDIR}"
}
