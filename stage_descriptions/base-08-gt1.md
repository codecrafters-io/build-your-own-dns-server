Your responses now contain the requested names, but their addresses are still
placeholders. In this stage, you'll forward questions to another DNS server and
return its answers to your client.

### Forwarding queries

A forwarding DNS server sends questions to an upstream resolver, the server
responsible for obtaining the answer. Your program handles the client's request
and response while the upstream server performs the lookup. You don't need a
local cache or your own authoritative records.

### Tests

The tester starts your program with the upstream resolver's address:

```bash
./your_program.sh --resolver <address>
```

`<address>` has the form `<ip>:<port>`.

It'll then send a UDP packet (containing a DNS query) to port 2053. Your program
will be responsible for forwarding DNS queries to a specified DNS server, and
then returning the response to the original requester (i.e. the tester).

Your program will need to respond with a DNS reply packet that contains:

- a header section with the request-derived fields
- a question section containing the client's questions
- an answer section carrying the records received from the upstream server,
  including their names, types, TTLs, and address data.

The tester sends only A-record queries in this stage.

Use these assumptions about the upstream server:

- Its replies contain an answer section for the tested queries.
- Its replies contain no authority or additional records.
- Treat it as supporting one question per query. A client request with multiple
  questions therefore requires one upstream query per question and one combined
  response to the client.

The client-facing response must retain the original request's ID and questions,
with counts matching its sections. Return the upstream address data instead of
the arbitrary addresses used in earlier stages.

### Notes

- Compression pointers refer to offsets within their own message. If you
  construct a new packet from part of another packet, its names must still refer
  to the correct bytes. Uncompressed names remain valid.
- The `--resolver` value is the upstream destination. Your server continues
  listening for clients on port `2053`.
