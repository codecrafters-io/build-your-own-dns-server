Up until now, we were ignoring the contents of the DNS packet that we received and hardcoding `1234` as the ID in the response. In
this stage, you'll have to parse the DNS packet that you receive and respond with the same ID in the response. You'll also need to set
some other fields in the header section.

Just like the previous stage, the tester will execute your program like this:

```bash
./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053.

Your program will need to respond with a DNS reply packet that contains a header section with the following values:

| Field                              | Size    | Expected value                                                              |
| ---------------------------------- | ------- | --------------------------------------------------------------------------- |
| Packet Identifier (ID)             | 16 bits | Mimic the 16 bit packet identifier from the request packet sent by tester   |
| Query/Response Indicator (QR)      | 1 bit   | 1                                                                           |
| Operation Code (OPCODE)            | 4 bits  | Mimic the OPCODE value sent by the tester                                   |
| Authoritative Answer (AA)          | 1 bit   | 0                                                                           |
| Truncation (TC)                    | 1 bit   | 0                                                                           |
| Recursion Desired (RD)             | 1 bit   | Mimic the RD value sent by the tester                                       |
| Recursion Available (RA)           | 1 bit   | 0                                                                           |
| Reserved (Z)                       | 3 bits  | 0                                                                           |
| Response Code (RCODE)              | 4 bits  | 0 (no error) if OPCODE is 0 (standard query) else 4 (not implemented)       |
| Question Count (QDCOUNT)           | 16 bits | Any valid value                                                             |
| Answer Record Count (ANCOUNT)      | 16 bits | Any valid value                                                             |
| Authority Record Count (NSCOUNT)   | 16 bits | Any valid value                                                             |
| Additional Record Count (ARCOUNT)  | 16 bits | Any valid value                                                             |

The tester will not check what follows the header section as long as it is a valid DNS packet.

**Note**: Your code will still need to pass tests for the previous stages. You shouldn't need to hardcode `1234` as the request ID anymore
since the tester sends `1234` as the ID in the previous stages. As long as you implement this stage correctly, your code should automatically pass
the previous stages as well.