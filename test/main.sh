source "$(dirname "${BASH_SOURCE}")"/../imosh || exit 1
eval "${IMOSH_INIT}"

imosh::test_files "$@"
