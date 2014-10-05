# func::fgets
func::fgets -- Gets a line from STDIN.

fgets reads a line and regards it as a result.  fgets does not strip a
trailing new line.  Function form sets the result to the variable.  Subroutine
form outputs the result to STDOUT.

## Usage
```sh
// 1. Function form.
bool func::fgets(string* variable)
// 2. Subroutine form.
bool sub::fgets() > line
```
