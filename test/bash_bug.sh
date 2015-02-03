# CAVEATS:
#   Some versions of BASH 4 have a bug around string comparation using double
#   brackets.
test::compare_string() {
  # BASH 4 fails.
  EXPECT_TRUE eval "[[ ' b' < 'a' ]]"
  EXPECT_TRUE eval "[ ' b' \\< 'a' ]"
  # BASH 4 fails.
  EXPECT_TRUE eval "[[ \$'\n' < ' ' ]]"
  EXPECT_TRUE eval "[ \$'\n' \\< ' ' ]"
  # BASH 4 fails.
  EXPECT_TRUE eval "[[ 'A' < 'a' ]]"
  EXPECT_TRUE eval "[ 'A' \\< 'a' ]"
  EXPECT_TRUE eval "[[ 'a' < 'aa' ]]"
  EXPECT_TRUE eval "[ 'a' \\< 'aa' ]"
}

# CAVEATS:
#   BASH 3 has a bug: $'\x01' in array is treated as $'\x01\x01'.
test::soh_in_array() {
  local values=($'\x01')
  local expected='01'
  local actual=''

  func::implode actual '' values
  func::bin2hex actual "${actual}"
  # BASH 3 fails.  SOH cannot be treated in array correctly.
  EXPECT_EQ "${expected}" "${actual}"
}

# CAVEATS:
#   BASH 4 does not actually prepare a variable while BASH 3 prepares a
#   variable.
test::isset() {
  local variable

  # BASH 4 fails.  local does not prepare a variable.
  EXPECT_ALIVE eval ": \"\${variable}\""

  local nullstr_variable=''
  EXPECT_ALIVE eval ": \"\${variable}\""
}

# CAVEATS:
#   BASH cannot expand an empty array.
test::empty_array() {
  local empty_array=()

  # BASH fails.
  EXPECT_ALIVE eval 'variable=("${empty_array[@]}")'
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
    # BASH fails if descriptor is not smaller than 10.
    EXPECT_EQ '' "${message}"
  done
  for descriptor in 3 9 10 100 200; do
    eval "exec ${descriptor}>&-"
    func::tmpfile file
    eval "exec ${descriptor}>\"\${file}\""
    "${BASH}" 'test/script/fd.sh' --descriptor="${descriptor}" --close
    func::file_get_contents message "${file}"
    EXPECT_EQ '' "${message}"
  done
}
