imosh::mktemp() {
  TMPDIR="${TMPDIR%/}"
  export IMOSH_TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/imosh.XXXXXX")"
  if [ "${IMOSH_TMPDIR}" == '' -o  "${IMOSH_TMPDIR}" == '/' ]; then
    LOG FATAL 'failed to create a temporary directory.'
  fi

  export __IMOSH_CORE_TMPDIR="${IMOSH_TMPDIR}/.imosh"
  mkdir "${__IMOSH_CORE_TMPDIR}"
  imosh::on_exit "rm -rf ${IMOSH_TMPDIR}"
}

TMPDIR="${TMPDIR:-/tmp}"
export TMPDIR="${TMPDIR%/}"
imosh::mktemp
