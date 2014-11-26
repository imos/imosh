# CAVEATS:
#   Some versions of BASH 4 have a bug around string comparation using double
#   brackets.
test::compare_string() {
  if [[ ! ' b' < 'a' ]]; then
    # BASH 4 fails.
    LOG ERROR 'string comparation is bad: [[ " b" < "a" ]]'
  fi
  if [ ! ' b' \< 'a' ]; then
    LOG ERROR 'string comparation is bad: [ " b" < "a" ]'
  fi
  if [[ ! $'\n' < ' ' ]]; then
    # BASH 4 fails.
    LOG ERROR 'string comparation is bad: [[ "\n" < " " ]]'
  fi
  if [ ! $'\n' \< ' ' ]; then
    LOG ERROR 'string comparation is bad: [ "\n" < " " ]'
  fi
  if [[ ! 'A' < 'a' ]]; then
    # BASH 4 fails.
    LOG ERROR 'string comparation is bad: [[ "A" < "a" ]]'
  fi
  if [ ! 'A' \< 'a' ]; then
    LOG ERROR 'string comparation is bad: [ "A" < "a" ]'
  fi
  if [[ ! 'a' < 'aa' ]]; then
    LOG ERROR 'string comparation is bad: [[ "a" < "aa" ]]'
  fi
  if [ ! 'a' \< 'aa' ]; then
    LOG ERROR 'string comparation is bad: [ "a" < "aa" ]'
  fi
}

# CAVEATS:
#   BASH 3 has a bug: $'\x01' in array is treated as $'\x01\x01'.
test::soh_in_array() {
  local values=($'\x01')
  local expected='01'
  local actual=''

  func::implode actual '' values
  func::bin2hex actual "${actual}"
  if [ "${expected}" != "${actual}" ]; then
    # BASH 3 fails.
    LOG ERROR "SOH cannot be treated in array correctly: ${actual}"
  fi
}

# CAVEATS:
#   BASH 4 does not actually prepare a variable while BASH 3 prepares a
#   variable.
test::isset() {
  local variable
  if ! EXPECT_ALIVE eval ": \"\${variable}\""; then
    # BASH 4 fails.
    LOG ERROR 'local does not prepare a variable.'
  fi

  local nullstr_variable=''
  if ! EXPECT_ALIVE eval ": \"\${nullstr_variable}\""; then
    LOG ERROR 'local does not prepare a variable.'
  fi
}

# CAVEATS:
#   BASH cannot expand an empty array.
test::empty_array() {
  local empty_array=()

  if ! EXPECT_ALIVE eval 'variable=("${empty_array[@]}")'; then
    # BASH fails.
    LOG ERROR 'Failed to expand an empty array.'
  fi
}

# CAVEATS:
#   BASH does not reopen a descriptor if its number is not smaller than 10 and
#   its parent process has already opened the descriptor.
test::file_descriptor() {
  local message='' descriptor=0 file=''
  for descriptor in 3 9 10 100 200; do
    eval "exec ${descriptor}>&-"
    func::tmpfile file
    eval "exec ${descriptor}>\"\${file}\""
    "${BASH}" 'test/script/fd.sh' --descriptor="${descriptor}"
    func::file_get_contents message "${file}"
    if [ "${message}" != '' ]; then
      # BASH fails if descriptor is not smaller than 10.
      LOG ERROR "File descriptor #${descriptor} is not reopened."
    fi
  done
  for descriptor in 3 9 10 100 200; do
    eval "exec ${descriptor}>&-"
    func::tmpfile file
    eval "exec ${descriptor}>\"\${file}\""
    "${BASH}" 'test/script/fd.sh' --descriptor="${descriptor}" --close
    func::file_get_contents message "${file}"
    if [ "${message}" != '' ]; then
      LOG ERROR "File descriptor #${descriptor} is not reopened."
    fi
  done
}
