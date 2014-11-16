__imosh::mktemp() {
  TMPDIR="${TMPDIR:-/tmp}"
  TMPDIR="${TMPDIR%/}"
  local suffix=''
  func::rand suffix 0 99999999
  func::substr suffix "00000000${suffix}" -8
  export TMPDIR="${TMPDIR}/imosh.${suffix}"
  if ! mkdir -p "${TMPDIR}"; then
    LOG FATAL "Failed to create a temporary directory: ${TMPDIR}"
  fi
  export IMOSH_TMPDIR="${TMPDIR}"

  export __IMOSH_CORE_TMPDIR="${TMPDIR}/.imosh"
  if ! mkdir "${__IMOSH_CORE_TMPDIR}"; then
    LOG FATAL "Failed to create a temporary directory: ${__IMOSH_CORE_TMPDIR}"
  fi
}
