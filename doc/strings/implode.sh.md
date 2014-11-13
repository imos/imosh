# implode
implode -- Joins array elements with a string.

func::implode joins `pieces` with `glue`.
*Stream form* uses the IFS environment variable as an input separator and
processes line by line.

## Usage
```sh
// 1. Function form.
void func::implode(string* variable, string glue, string[]* pieces)
// 2. Command form.
void sub::implode(string glue, string[]* pieces) > result
void sub::implode(string[]* pieces) > result
// 3. Stream form.
void stream::implode(string glue) < input > output
```


## Aliases
  func::join, sub::join and stream::join are aliases of func::implode,
  sub::implode and stream::implode respectively.
