# Close descriptors for logs beforehand for BASH3's bug.
exec 101>&- 102>&- 103>&- 104>&-
# Open descriptors for LOG without calling init_log.
exec 101>/dev/null 102>/dev/null 103>/dev/null 104>/dev/null
# Redirect log output to the current STDERR.
exec 105>&-
exec 105>&2
