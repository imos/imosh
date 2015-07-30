# array_is_empty
array_is_empty -- Checks if an array is empty.

array_is_empty returns true iff a given array is empty.

## Usage
```sh
// 1. Command form.
bool sub::array_is_empty(string[]* variable)
```


## Example
```sh
array=()
if sub::array_is_empty array; then
  echo 'array is empty.'
fi
```
