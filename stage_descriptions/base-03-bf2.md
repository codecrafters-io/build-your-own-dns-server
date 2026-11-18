Your response currently contains only a header. Repeating the question lets the
client see which name and record type the response concerns. In this stage,
you'll add a question section for `codecrafters.io`.

### Question section structure

The question section contains a list of questions (usually just 1) that the
sender wants to ask the receiver. This section is present in both query and
reply packets.

Each question has the following structure:

- **Name**: A domain name, represented as a sequence of "labels" (more on this
  below)
- **Type**: A 2-byte integer identifying the requested data. An A record (`1`)
  contains an IPv4 address. A CNAME record (`5`) names an alias target. See the
  [full type list](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.2).
- **Class**: A 2-byte integer identifying the namespace. This challenge uses the
  Internet class, IN (`1`). See the
  [full class list](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.4).

The fields appear in this order, with no separators between them. Type and class
use big-endian byte order.

[Section 4.1.2](https://www.rfc-editor.org/rfc/rfc1035#section-4.1.2) of the RFC
covers the question section format in detail.
[Section 3.2](https://www.rfc-editor.org/rfc/rfc1035#section-3.2) has more
details on Type and class.

### Domain name encoding

Each dot-separated component of a domain name is a label. DNS stores these
labels with byte lengths instead of the dots.

Labels are encoded as `<length><content>`, where `<length>` is a single byte
that specifies the length of the label, and `<content>` contains that many bytes
of the name. The length excludes the length byte itself. A zero length ends the
name, so the sequence is terminated by a null byte (`\x00`). The `\xNN` notation
below represents individual byte values.

For example, `google.com` is encoded as `\x06google\x03com\x00` (in hex:
`06 67 6f 6f 67 6c 65 03 63 6f 6d 00`).

- `\x06google` is the first label. The single byte `\x06` gives the six-byte
  length of `google`.
- `\x03com` is the second label. The single byte `\x03` gives the three-byte
  length of `com`.
- `\x00` terminates the name.

### Tests

The tester will execute your program like this:

```bash
./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053. Your program
will need to respond with a DNS reply packet containing the question section
described above and the existing header.

Here are the expected values for the question section:

| Field | Expected value                                                                                          |
| ----- | ------------------------------------------------------------------------------------------------------- |
| Name  | `\x0ccodecrafters\x02io` followed by a null byte (that's `codecrafters.io` encoded as a label sequence) |
| Type  | 1 encoded as a 2-byte big-endian int (corresponding to the "A" record type)                             |
| Class | 1 encoded as a 2-byte big-endian int (corresponding to the "IN" record class)                           |

Set `QDCOUNT` to `1` for the single question and keep the ID at `1234`. The
answer, authority, and additional sections remain empty. You can still use this
fixed name rather than parsing the incoming question.
