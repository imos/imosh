# func::implode
func::implode -- Joins array elements with a string.

func::implode joins `pieces` with `glue`.
*Stream form* uses the IFS environment variable as an input separator and
processes line by line.

## Usage
```sh
// 1. Function form.
void func::implode(string* variable, string glue, string[]* pieces)
// 2. Command form.
void func::implode(string glue, string[]* pieces) > result
// 3. Stream form.
void func::implode(string glue) < input > output
```


## Alias
  func::join is an alias of func::implode.
