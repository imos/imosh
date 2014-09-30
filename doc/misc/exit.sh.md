# func::exit, func::die

## Usage
  // 1. Message form.
  void func::exit(string message)
  // 2. Status form.
  void func::exit(int status = 0)
  // 1. Message form.
  void func::die(string message)
  // 2. Status form
  void func::die(int status = 0)

func::exit kills all the subprocesses of the current program.  If an integer
argument is given, func::exit exists with the status.  Otherwise, func::exit
shows the given message and exits with status 0.

func::die shows a stack trace and delegates arguments to func::exit.
