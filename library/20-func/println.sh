# Usage:
#   void func::println(string message...) > output
#
# Print message to the standard output with a new line.  While "echo" consumes
# flags, func::println does not consume any flags, so this is theoretically
# safe.
func::println() {
  printf "%s\n" "$*"
}
