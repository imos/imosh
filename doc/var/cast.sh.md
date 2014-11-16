# cast
cast -- Casts a variable.

Casts variable into a specified type.

## Usage
```sh
// 1. Function form.
bool func::cast(variant* variable, string type)
// 2. Function form. (Dies if conversion fails.)
void func::cast_or_die(variant* variable, string type)
```
