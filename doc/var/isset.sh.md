# isset
isset -- Checks if a variable exists.

Returns true iff variable exists.

## Usage
```sh
// 1. Function form.
void func::isset(bool* result, variant* variable)
// 2. Command form.
bool func::isset(variant* variable)
```


## CAVEATS
  func::isset returns true for uninitialized variables in BASH 3, and returns
  false for them in BASH 4.
