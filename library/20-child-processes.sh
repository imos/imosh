imosh::get_child_processes() {
  local ppid="$1"
  ps -axo ppid,pid | awk "{ if (\$1 == ${ppid}) print \$2; }"
}
