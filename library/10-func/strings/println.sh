# func::println -- Prints a message with a new line.
#
# Print message to the standard output with a new line.  While "echo" consumes
# flags, func::println does not consume any flags, so this is theoretically
# safe.
#
# Usage:
#   void func::println(string message...) > output
func::println() {
  printf "%s\n" "$*"
}
