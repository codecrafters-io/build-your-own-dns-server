Your response repeats a question but has no address to give the client yet. In
this stage, you'll add an answer section containing one A record for
`codecrafters.io`.

### Answer section structure

The answer section contains resource records, often abbreviated RRs. A record
associates a name with typed data and a lifetime for caching that data. You can
choose the address for now.

Each RR has the following structure:

| Field               | Type           | Description                                                                                                                    |
| ------------------- | -------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| Name                | Label Sequence | The domain name encoded as a sequence of labels.                                                                               |
| Type                | 2-byte Integer | `1` for an A record, `5` for a CNAME record. See the [record type list](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.2). |
| Class               | 2-byte Integer | Usually set to `1`. See the [record class list](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.4).                         |
| TTL (Time-To-Live)  | 4-byte Integer | The duration in seconds a record can be cached before requerying.                                                              |
| Length (`RDLENGTH`) | 2-byte Integer | Length of the RDATA field in bytes.                                                                                            |
| Data (`RDATA`)      | Variable       | Data specific to the record type.                                                                                              |

[Section 3.2.1](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.1) of the RFC
covers the answer section format in detail.

The fields appear in the table's order, and integer fields use big-endian byte
order. The variable-length name uses the same label encoding as a question.

This stage only uses A records, which map a domain name to an IPv4 address.
Their RDATA is four bytes, one for each decimal component of the address in
order. For example, `1.2.3.4` becomes `01 02 03 04`. `RDLENGTH` is therefore
`4`. An address written as text would have a different representation.

### Tests

The tester will execute your program like this:

```bash
./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053.

Your program will need to respond with a DNS reply packet that contains:

- the existing header section, with its counts updated
- the existing question section
- an answer section (**new in this stage!**)

Your answer section should contain a single RR, with the following values:

| Field  | Expected Value                                                                                                                     |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| Name   | `\x0ccodecrafters\x02io` followed by a null byte (that's `codecrafters.io` encoded as a label sequence)                            |
| Type   | `1` encoded as a 2-byte big-endian int (corresponding to the "A" record type)                                                      |
| Class  | `1` encoded as a 2-byte big-endian int (corresponding to the "IN" record class)                                                    |
| TTL    | Any value, encoded as a 4-byte big-endian int. For example: `60`.                                                                  |
| Length | `4`, encoded as a 2-byte big-endian int (corresponds to the length of the RDATA field)                                             |
| Data   | Any IP address, encoded as a 4-byte big-endian int. For example: `\x08\x08\x08\x08` (that's `8.8.8.8` encoded as a 4-byte integer) |

Set `ANCOUNT` to `1` for this answer. Keep `QDCOUNT` at `1`, the ID at `1234`,
and the authority and additional counts at `0`. This fixed answer teaches the
record format. Looking up an address comes later.
