# func::throttle
func::throttle -- Throttles by the number of child processes.

throttle waits that the number of the child processes is less than a limit.
Firstly, throttle waits for 0.1 second, and the n-th retry (n < 10) waits for
n * 0.1 seconds.  The n-th retry (n >= 10) waits for 1 second.

## Usage
```sh
void func::throttle(int limit)
```
