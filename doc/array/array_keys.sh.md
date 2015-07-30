# array_keys
array_keys -- Gets an array's keys.

array_keys gets an array's keys.

## Usage
```sh
// 1. Function form.
void func::array_keys(string[]* output, string[]* input)
// 2. Command form.
void sub::array_keys(string[]* input) > output
```


## Examples
```sh
array=([0]=abc [2]=def)
EXPECT_EQ '0,2' "$(IFS=, sub::array_keys array)"
func::array_keys result array
EXPECT_EQ '0' "${result[0]}"
EXPECT_EQ '2' "${result[1]}"
```
