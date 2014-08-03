Introduction
============

imosh is a library for bash.
It consists of a flag library and a PHP-like function library.

imosh is tested on drone.io (https://drone.io/github.com/imos/imosh).

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
DEFINE_<type> <flag name> <default value> <flag description>
```

Flag Types
----------

* string ... string type,
* bool ... boolean type,
* int ... integer type.

Flag Options
------------

* --alias=`alias name` ... declares a flag alias.  This is useful for short flag names.
