# function_exists
function_exists -- Returns true iff the given function has been defined.

Checks the list of defined functions, both built-in (internal) and
user-defined, for function_name.

## Usage
```sh
// 1. Command form.
bool sub::function_exists(string function_name)
```


## Examples
```sh
EXPECT_TRUE sub::function_exists func::array
```
