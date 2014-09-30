Introduction
============

imosh is a library for bash.
It consists of utilities like gflags and glog and PHP-like functions.

imosh is tested on drone.io (https://drone.io/github.com/imos/imosh).

Supported BASH versions
-----------------------

* BASH 3.2.51 on Mac OSX Mavericks
* BASH 4.2.25 on Ubuntu 14.04


Features
========

Man-like help
-------------

imosh can show a help page like a man page.

![imosh help page](https://raw.github.com/wiki/imos/imosh/images/help.png)

Stack trace
-----------

imosh shows a stack trace when some error arises.

![imosh stack trace](https://raw.github.com/wiki/imos/imosh/images/stacktrace.png)

gflags-like flag definitions
----------------------------

imosh enables shell scripts to use flag definitions like gflags.

```sh
DEFINE_string 'string' 'default' 'String flag.'
DEFINE_int 'int' 100 'Integer flag.'
DEFINE_bool 'bool' false 'Boolean flag.'
```

Glog-like logging
-----------------

imosh provides a standard way for logging like glog.

```sh
LOG ERROR 'some error happens!'
```

Usage
=====

Copy imosh in the top directory to some directory listed in `${PATH}`.

```sh
source imosh || exit 1

DEFINE_string 'string' 'default' 'String flag.'
DEFINE_int 'int' 100 'Integer flag.'
DEFINE_bool 'bool' false 'Boolean flag.'

eval "${IMOSH_INIT}"
```

Terminal
--------

imosh is also useful for regular shell operations.
You can use imosh by running the following command beforehand:

```sh
source imosh
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

Other Features
--------------

* The --help (-h) flag is defined, and it shows the list of flags defined in the script.
* Environment variables specified by `IMOSH_FLAGS_<flag name>` change flags' default values.


Logging
=======

```sh
LOG <severity> <message>
```

Severity
--------

* `INFO` is NOT output to stderr by default,
* `WARNING` is NOT output to stderr by default,
* `ERROR` is output to stderr by default,
* `FATAL` is output to stderr by default.

Flags
-----

* `--alsologtostderr` makes all severities output to stderr in addition to log files,
* `--logtostderr` makes all severities output to stderr instead of log files.

Path to Output
--------------

imosh outputs log files to `${TMPDIR}/<program name>.<host name>.<user>.<severity>.<date>.<time>.<process ID>`.

<!-- MARKER:AUTO_GENERATED -->

# Functions
* Strings
