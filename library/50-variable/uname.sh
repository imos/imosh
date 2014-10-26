if func::isset UNAME; then
  readonly UNAME="${UNAME}"
else
  readonly UNAME="$(uname)"
fi
