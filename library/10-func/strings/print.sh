# print -- Prints a message.
#
# Print message to the standard output.  While "echo" consumes flags,
# print does not consume any flags, so this is theoretically safe.
#
# Usage:
#     // DEPRECATED
#     void func::print(string message...) > output
#     // 1. Command form.
#     void sub::print(string message...) > output
func::print() {
  printf "%s" "$*"
}

sub::print() {
  IFS=' ' eval 'printf "%s" "$*"'
}