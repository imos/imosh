# exit, die
exit, die -- Kills the current script.

sub::exit kills all the subprocesses of the current program.  If an integer
argument is given, sub::exit exits with the status.  Otherwise, sub::exit
shows the given message and exits with status 0.  sub::die shows a stack
trace and delegates arguments to sub::exit.

## Usage
```sh
// 1-a. Command form with a message.
void sub::exit(string message)
// 1-b. Command form with a status.
void sub::exit(int status = 0)
// 1-c. Command form with a message.
void sub::die(string message)
// 1-d. Command form with a status.
void sub::die(int status = 0)
```
