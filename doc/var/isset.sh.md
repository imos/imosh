# isset
isset -- Checks if a variable exists.

Returns true iff variable exists.

## Usage
```sh
bool func::isset(variant* variable)
```


## CAVEATS
  func::isset returns true for uninitialized variables in BASH 3, and returns
  false for them in BASH 4.
