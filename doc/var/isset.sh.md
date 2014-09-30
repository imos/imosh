# func::isset
func::isset -- Checks if a variable exists.

## Usage
  bool func::isset(variant* variable)

Returns true iff variable exists.

CAVEATS: func::isset returns true for uninitialized variables in BASH 3, and
         returns false for them in BASH 4.
