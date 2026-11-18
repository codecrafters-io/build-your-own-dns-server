Your server can send a UDP reply. A DNS header lets clients identify the request
and interpret the response. In this stage, you'll write that header with fixed
values.

### Header section structure

A DNS message has five sections: header, question, answer, authority, and
additional. The header is always present and gives the number of entries in each
later section. For this stage, those sections are empty.

Use these values for the response header:

| Field                             | Size    | Meaning                                                     | Value          |
| --------------------------------- | ------- | ----------------------------------------------------------- | -------------- |
| Packet identifier (ID)            | 16 bits | Identifies the query this reply answers.                    | `1234`         |
| Query/response indicator (QR)     | 1 bit   | `1` for a response, `0` for a query.                        | `1`            |
| Operation code (OPCODE)           | 4 bits  | The requested operation.                                    | `0`            |
| Authoritative answer (AA)         | 1 bit   | Whether the server is responsible for this name's DNS data. | `0`            |
| Truncation (TC)                   | 1 bit   | Whether the message was shortened to fit a size limit.      | `0`            |
| Recursion desired (RD)            | 1 bit   | Whether the client requests recursive resolution.           | `0`            |
| Recursion available (RA)          | 1 bit   | Whether the server offers recursive resolution.             | `0`            |
| Reserved (Z)                      | 3 bits  | Originally reserved. Some bits now serve DNSSEC.            | `0`            |
| Response code (RCODE)             | 4 bits  | The response status.                                        | `0` (no error) |
| Question count (QDCOUNT)          | 16 bits | Number of questions.                                        | `0`            |
| Answer record count (ANCOUNT)     | 16 bits | Number of answer records.                                   | `0`            |
| Authority record count (NSCOUNT)  | 16 bits | Number of authority records.                                | `0`            |
| Additional record count (ARCOUNT) | 16 bits | Number of additional records.                               | `0`            |

Recursive resolution obtains a complete answer, potentially by querying other
DNS servers. It and the DNSSEC security extensions are outside this stage.

The header is always 12 bytes long. The fields appear in the table's order. QR
through RCODE occupy one 16-bit flags field, with QR in its most significant
bit. Each flag uses only the number of bits shown, so they share bytes.

The ID, flags, and four counts are each two bytes. These integers use big-endian
order: the most significant byte comes first. For example, decimal `1234` is
hexadecimal `04 d2`, and a count of one is `00 01`.

With the fixed values above, the complete response is these 12 bytes:

```text
04 d2 80 00 00 00 00 00 00 00 00 00
```

This is a hexadecimal display of the bytes. Send their binary values over UDP.

You can read more about the full DNS packet format on
[Wikipedia's DNS message format description](https://en.wikipedia.org/wiki/Domain_Name_System#DNS_message_format),
or in [RFC 1035](https://tools.ietf.org/html/rfc1035#section-4.1). The
[DNS packet format walkthrough](https://github.com/EmilHernvall/dnsguide/blob/b52da3b32b27c81e5c6729ac14fe01fef8b1b593/chapter1.md)
explains the format in more detail.

### Tests

The tester will execute your program like this:

```bash
$ ./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053. Your program
will need to respond with a DNS reply packet that contains the header
information described above.

### Notes

- Parsing request fields comes later. The fixed values in this stage are a
  temporary response.
- The tester sends an extra packet at startup to check that your server
  responds. Give it the same UDP reply handling as other packets. Its payload
  needs no special handling.
