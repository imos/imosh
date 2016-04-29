# array_values
array_values -- Copies elements from an array to an array.

array_values copies elements in an array variable into an array variable.

## Usage
```sh
// 1. Function form.
void func::array_values(string[]* output, string[]* input)
// 2. Command form.
void sub::array_values(string[]* input) > output
```


## Examples
```sh
array=(foo bar)
EXPECT_EQ 'foo,bar' "$(IFS=, sub::array_values array)"
```
