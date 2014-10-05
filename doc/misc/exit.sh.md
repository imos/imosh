# exit, die
exit, die -- Kills the current script.

func::exit kills all the subprocesses of the current program.  If an integer
argument is given, func::exit exits with the status.  Otherwise, func::exit
shows the given message and exits with status 0.  func::die shows a stack
trace and delegates arguments to func::exit.

## Usage
```sh
// 1-a. Function form with a message.
void func::exit(string message)
// 1-b. Function form with a status.
void func::exit(int status = 0)
// 1-c. Function form with a message.
void func::die(string message)
// 1-d. Function form with a status.
void func::die(int status = 0)
```
