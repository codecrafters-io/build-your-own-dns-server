In this stage, we'll setup a UDP server that can receive and respond to UDP packets on port 2053.

The tester will execute your program like this:

```bash
$ ./your_program.sh
```

The tester will then send a UDP packet to port 2053.

Your program should respond back with a UDP packet. It's okay to ignore the contents of the packet for now,
we'll work on that in the next stage.