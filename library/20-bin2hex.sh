bin2hex() {
  if [ "$#" -eq 0 ]; then
    od -An -tx1 | tr -d ' \n'
  else
    print "$*" | bin2hex
  fi
}
