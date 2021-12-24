# cause_crash_dump

A small utility program that will run and then crash. Primarily for use with testing any crash dump collection utilities and scripts.

## To Build

Run the `build.sh` script.

```shell
./build.sh
```

## To Test

Run the `test.sh` script.

```shell
./test.sh
```

and you should be some console output similar to this:

```
$ ./test.sh 

-- Increase soft-limit for core dump file size
core file size          (blocks, -c) unlimited
data seg size           (kbytes, -d) unlimited
file size               (blocks, -f) unlimited
max locked memory       (kbytes, -l) unlimited
max memory size         (kbytes, -m) unlimited
open files                      (-n) 2560
pipe size            (512 bytes, -p) 1
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 1392
virtual memory          (kbytes, -v) unlimited

-- Run application
This program will core dump in ....
... 3 ... 2 ... 1 ... Boom!
./test.sh: line 25: 95810 Floating point exception: 8   ./src/cause_crash_dump
-- Application failed as expected
```