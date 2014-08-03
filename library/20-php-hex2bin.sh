php::hex2bin() {
  local message="$(
      print "$*" | tr -c -d '[0-9a-fA-F]' | fold -w 2 \
          | sed -e 's/^/\\x/' | tr -d '[:space:]')"
  printf "${message}"
}
