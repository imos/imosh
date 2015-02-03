run_testcase() {
  local expected="$1"; shift

  local variable=''
  func::substr variable "$@"
  EXPECT_EQ "${expected}" "${variable}"
  EXPECT_EQ "${expected}" "$(sub::substr "$@")"
}

test::substr() {
  run_testcase 'bc'  'abc' -2
  run_testcase ''    'abc' -2 -3
  run_testcase ''    'abc' -2 -2
  run_testcase 'b'   'abc' -2 -1
  run_testcase ''    'abc' -2 0
  run_testcase 'b'   'abc' -2 1
  run_testcase 'bc'  'abc' -2 2
  run_testcase 'bc'  'abc' -2 3

  run_testcase 'abc' 'abc' 0
  run_testcase ''    'abc' 0 -4
  run_testcase ''    'abc' 0 -3
  run_testcase 'a'   'abc' 0 -2
  run_testcase 'ab'  'abc' 0 -1
  run_testcase ''    'abc' 0 0
  run_testcase 'a'   'abc' 0 1
  run_testcase 'abc' 'abc' 0 3
  run_testcase 'abc' 'abc' 0 5

  run_testcase 'bc'  'abc' 1
  run_testcase ''    'abc' 1 -3
  run_testcase ''    'abc' 1 -2
  run_testcase 'b'   'abc' 1 -1
  run_testcase ''    'abc' 1 0
  run_testcase 'b'   'abc' 1 1
  run_testcase 'bc'  'abc' 1 3

  run_testcase ''    'abc' 3
  run_testcase ''    'abc' 5

  run_testcase ''    'abc' 9 -9
  run_testcase ''    'abc' 9 -1
  run_testcase ''    'abc' 9 0
  run_testcase ''    'abc' 9 9
}
