In this stage, you'll extend your DNS server to respond with the "answer" section, the third section of a DNS message.

### Answer section structure

The answer section contains a list of RRs (Resource Records), which are answers to the questions asked in the question section.

Each RR has the following structure:

| Field                 | Type            | Description                                                                                                              |
| --------------------- | --------------- | ------------------------------------------------------------------------------------------------------------------------ |
| Name                  | Label Sequence  | The domain name encoded as a sequence of labels.                                                                         |
| Type                  | 2-byte Integer  | `1` for an A record, `5` for a CNAME record etc., full list [here](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.2) |
| Class                 | 2-byte Integer  | Usually set to `1` (full list [here](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.4))                              |
| TTL (Time-To-Live)    | 4-byte Integer  | The duration in seconds a record can be cached before requerying.                                                        |
| Length (`RDLENGTH`)   | 2-byte Integer  | Length of the RDATA field in bytes.                                                                                      |
| Data (`RDATA`)        | Variable        | Data specific to the record type.                                                                                        |

[Section 3.2.1](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.1) of the RFC covers the answer section format in detail.

In this stage, we'll only deal with the "A" record type, which maps a domain name to an IPv4 address. The RDATA field for an "A" record
type is a 4-byte integer representing the IPv4 address.

---

Just like in the previous stage, the tester will execute your program like this:

```bash
./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053.

Your program will need to respond with a DNS reply packet that contains:

- a header section (same as in stage #2)
- a question section  (same as in stage #3)
- an answer section (**new in this stage!**)

Your answer section should contain a single RR, with the following values:

| Field   | Expected Value                                                                                                                     |
| ------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Name    | `\x0ccodecrafters\x02io` followed by a null byte (that's `codecrafters.io` encoded as a label sequence)                            |
| Type    | `1` encoded as a 2-byte big-endian int (corresponding to the "A" record type)                                                      |
| Class   | `1` encoded as a 2-byte big-endian int (corresponding to the "IN" record class)                                                    |
| TTL     | Any value, encoded as a 4-byte big-endian int. For example: `60`.                                                                  |
| Length  | `4`, encoded as a 2-byte big-endian int (corresponds to the length of the RDATA field)                                             |
| Data    | Any IP address, encoded as a 4-byte big-endian int. For example: `\x08\x08\x08\x08` (that's `8.8.8.8` encoded as a 4-byte integer) |

Make sure to update the `ANCOUNT` field in the header section accordingly, and remember to set the id to `1234`.