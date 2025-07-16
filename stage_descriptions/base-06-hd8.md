In this stage you'll extend your DNS server to parse the question section of the DNS message you receive.

Just like the previous stage, the tester will execute your program like this:

```bash
./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053 that contains a question section as follows:

| Field  | Value sent by the tester                                                        |
| ------ | --------------------------                                                      |
| Name   | A random domain encoded as a label sequence (refer to stage #3 for details)     |
| Type   | `1` encoded as a 2-byte big-endian int (corresponding to the "A" record type)   |
| Class  | `1` encoded as a 2-byte big-endian int (corresponding to the "IN" record class) |

The question type will always be `A` for this stage and the question class will always be `IN`. So your parser only needs to account for those record types for now.

Your program will need to respond with a DNS reply packet that contains:

- a header section (same as in stage #5)
- a question section (**new in this stage**)
- an answer section (**new in this stage**)

**Expected values for the question section**:

| Field  | Expected value                                                                  |
| ------ | --------------------------                                                      |
| Name   | Mimic the domain name (as label sequence)                                       |
| Type   | `1` encoded as a 2-byte big-endian int (corresponding to the "A" record type)   |
| Class  | `1` encoded as a 2-byte big-endian int (corresponding to the "IN" record class) |

**Expected values for the answer section**:

| Field   | Expected Value                                                                                                                     |
| ------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Name    | Mimic the domain name (as label sequence)                                                                                          |
| Type    | `1` encoded as a 2-byte big-endian int (corresponding to the "A" record type)                                                      |
| Class   | `1` encoded as a 2-byte big-endian int (corresponding to the "IN" record class)                                                    |
| TTL     | Any value, encoded as a 4-byte big-endian int. For example: `60`.                                                                  |
| Length  | `4`, encoded as a 2-byte big-endian int (corresponds to the length of the RDATA field)                                             |
| Data    | Any IP address, encoded as a 4-byte big-endian int. For example: `\x08\x08\x08\x08` (that's `8.8.8.8` encoded as a 4-byte integer) |