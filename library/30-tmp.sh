imosh::mktemp() {
  TMPDIR="${TMPDIR%/}"
  export TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/imosh.XXXXXX")"

  if [ "${TMPDIR}" == '' -o  "${TMPDIR}" == '/' ]; then
    LOG FATAL 'failed to create a temporary directory.'
  fi

  export __IMOSH_TMPDIR="${TMPDIR}/.imosh"
  mkdir "${__IMOSH_TMPDIR}"
  imosh::on_exit "rm -rf ${TMPDIR}"
}

imosh::mktemp
