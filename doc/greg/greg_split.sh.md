# greg_split
greg_split -- Splits a string with a GREG pattern.

greg_split splits a string with a GREG pattern.

## Usage
```sh
// 1. Function form.
void func::greg_split(string[]* variable, string pattern, string value)
// 2. Command form.
void sub::greg_split(string pattern, string value)
```


## Caveat
  greg_split does not support \x02 for value.
