Your DNS messages need a way to reach clients over the network. In this stage,
you'll start a UDP server on `127.0.0.1:2053` that replies to incoming packets.

### UDP datagrams

UDP carries individual messages called datagrams. A receiving socket gets both
the datagram's bytes and the sender's address, which identifies where to send
the reply. There is no connection handshake to accept.

### Tests

Run your server with `./your_program.sh`. The tester sends a datagram to port
`2053` and expects a reply at the sending address. Any response payload,
including an empty one, is enough for this stage. Keep the server running to
handle later packets.

### Notes

- You don't need to parse DNS messages yet.
- The tester may pass `--resolver <ip>:<port>` at startup. You can ignore that
  option until you implement upstream lookups.
- DNS also supports other transports. This challenge uses UDP on port `2053` so
  it doesn't need the usual DNS port, `53`.
