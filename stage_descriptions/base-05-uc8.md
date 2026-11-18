Your server currently uses fixed header values, including ID `1234`. Matching
IDs let the client associate a reply with its request. In this stage, you'll
read the request header and copy its ID, OPCODE, and RD fields into the
response.

### Response header fields

The response still has its own flags. Set QR to `1`, keep AA, TC, RA, and Z at
`0`, and use RCODE to report whether the requested operation is supported. The
byte order and packed-bit layout are unchanged.

### Tests

The tester will execute your program like this:

```bash
./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053.

Your program will need to respond with a DNS reply packet that contains a header
section with the following values:

| Field                             | Size    | Expected value                                                            |
| --------------------------------- | ------- | ------------------------------------------------------------------------- |
| Packet Identifier (ID)            | 16 bits | Mimic the 16 bit packet identifier from the request packet sent by tester |
| Query/Response Indicator (QR)     | 1 bit   | 1                                                                         |
| Operation Code (OPCODE)           | 4 bits  | Mimic the OPCODE value sent by the tester                                 |
| Authoritative Answer (AA)         | 1 bit   | 0                                                                         |
| Truncation (TC)                   | 1 bit   | 0                                                                         |
| Recursion Desired (RD)            | 1 bit   | Mimic the RD value sent by the tester                                     |
| Recursion Available (RA)          | 1 bit   | 0                                                                         |
| Reserved (Z)                      | 3 bits  | 0                                                                         |
| Response Code (RCODE)             | 4 bits  | 0 (no error) if OPCODE is 0 (standard query) else 4 (not implemented)     |
| Question Count (QDCOUNT)          | 16 bits | Any valid value                                                           |
| Answer Record Count (ANCOUNT)     | 16 bits | Any valid value                                                           |
| Authority Record Count (NSCOUNT)  | 16 bits | Any valid value                                                           |
| Additional Record Count (ARCOUNT) | 16 bits | Any valid value                                                           |

The tester checks the header in this stage. The complete response must remain a
valid DNS packet, with each count matching the number of entries you actually
include. Copying the entire request header unchanged would leave QR indicating a
query and would miss the required RCODE rule.

### Notes

- Keep the behavior required by earlier stages. Their requests use ID `1234`, so
  copying the incoming ID preserves that result without hardcoding it.
- OPCODE `0` is a standard query. For other OPCODE values, RCODE `4` means the
  operation is not implemented. You don't need to implement those operations.
