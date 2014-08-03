imosh
=====

Libraries for bash

Usage
=====

```sh
source imosh || exit 1

DEFINE_string 'flag' '' 'Flag name to show.'
DEFINE_string 'string' 'default' 'String flag.'
DEFINE_int 'int' 100 'Integer flag.'
DEFINE_bool 'bool' false 'Boolean flag.'

eval "${IMOSH_INIT}"
```

Flag Definition
===============

```sh
DEFINE_(type) (flag name) (default value) (flag description)
```

Flag Types
----------

* string ... string type.
* bool ... bolean type.
* int ... integer type.
