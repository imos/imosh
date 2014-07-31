TMPDIR="${TMPDIR%/}"
export TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/imosh.XXXXXX")"

if [ "${TMPDIR}" == '' -o  "${TMPDIR}" == '/' ]; then
  LOG FATAL 'failed to create a temporary directory.'
fi

imosh::on_exit 'rm -rf ${TMPDIR}'

