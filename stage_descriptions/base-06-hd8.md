Your header now reflects the request, but the response name is still fixed. In
this stage, you'll read the incoming question and use its domain name in both
the returned question and A record.

### Reading the question

You can still choose any IPv4 address for the answer.

The question uses the label lengths, terminating zero, type, and class taught
earlier. This stage uses an uncompressed name and one question. Name compression
comes next.

### Tests

The tester will execute your program like this:

```bash
./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053 that contains
a question section as follows:

| Field | Value sent by the tester                                                        |
| ----- | ------------------------------------------------------------------------------- |
| Name  | A random domain using the label encoding taught earlier                         |
| Type  | `1` encoded as a 2-byte big-endian int (corresponding to the "A" record type)   |
| Class | `1` encoded as a 2-byte big-endian int (corresponding to the "IN" record class) |

The question type will always be `A` for this stage and the question class will
always be `IN`. So your parser only needs to account for those record types for
now.

Your program will need to respond with a DNS reply packet that contains:

- a header section with the request-derived fields
- a question section containing the requested name
- an answer section containing an A record for that same name

**Expected values for the question section**:

| Field | Expected value                                                                  |
| ----- | ------------------------------------------------------------------------------- |
| Name  | Mimic the domain name (as label sequence)                                       |
| Type  | `1` encoded as a 2-byte big-endian int (corresponding to the "A" record type)   |
| Class | `1` encoded as a 2-byte big-endian int (corresponding to the "IN" record class) |

**Expected values for the answer section**:

| Field  | Expected Value                                                                                                                     |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| Name   | Mimic the domain name (as label sequence)                                                                                          |
| Type   | `1` encoded as a 2-byte big-endian int (corresponding to the "A" record type)                                                      |
| Class  | `1` encoded as a 2-byte big-endian int (corresponding to the "IN" record class)                                                    |
| TTL    | Any value, encoded as a 4-byte big-endian int. For example: `60`.                                                                  |
| Length | `4`, encoded as a 2-byte big-endian int (corresponds to the length of the RDATA field)                                             |
| Data   | Any IP address, encoded as a 4-byte big-endian int. For example: `\x08\x08\x08\x08` (that's `8.8.8.8` encoded as a 4-byte integer) |

The response has one question and one answer, so both `QDCOUNT` and `ANCOUNT`
are `1`. Keep the existing header-parsing behavior.
