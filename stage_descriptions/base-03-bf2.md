In this stage, you'll extend your DNS server to respond with the "question" section, the second section of a DNS message.

### Question section structure

The question section contains a list of questions (usually just 1) that the sender wants to ask the receiver. This section is present
in both query and reply packets.

Each question has the following structure:

- **Name**: A domain name, represented as a sequence of "labels" (more on this below)
- **Type**: 2-byte int; the type of record (1 for an A record, 5 for a CNAME record etc., full list [here](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.2))
- **Class**: 2-byte int; usually set to `1` (full list [here](https://www.rfc-editor.org/rfc/rfc1035#section-3.2.4))

[Section 4.1.2](https://www.rfc-editor.org/rfc/rfc1035#section-4.1.2) of the RFC covers the question section format in
detail. [Section 3.2](https://www.rfc-editor.org/rfc/rfc1035#section-3.2) has more details on Type and class.

### Domain name encoding

Domain names in DNS packets are encoded as a sequence of labels.

Labels are encoded as `<length><content>`, where `<length>` is a single byte that specifies the length of the label,
and `<content>` is the actual content of the label. The sequence of labels is terminated by a null byte (`\x00`).

For example:

- `google.com` is encoded as `\x06google\x03com\x00` (in hex: `06 67 6f 6f 67 6c 65 03 63 6f 6d 00`)
  - `\x06google` is the first label
      - `\x06` is a single byte, which is the length of the label
      - `google` is the content of the label
  - `\x03com` is the second label
      - `\x03` is a single byte, which is the length of the label
      - `com` is the content of the label
  - `\x00` is the null byte that terminates the domain name

---

Just like in the previous stage, the tester will execute your program like this:

```bash
./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053. Your program will need to respond with a
DNS reply packet that contains the question section described above (along with the header section from the previous stage).

Here are the expected values for the question section:

| Field | Expected value                                                                                          |
| ----- | ------------------------------------------------------------------------------------------------------- |
| Name  | `\x0ccodecrafters\x02io` followed by a null byte (that's `codecrafters.io` encoded as a label sequence) |
| Type  | 1 encoded as a 2-byte big-endian int (corresponding to the "A" record type)                             |
| Class | 1 encoded as a 2-byte big-endian int (corresponding to the "IN" record class)                           |

Make sure to update the `QDCOUNT` field in the header section accordingly, and remember to set the id to `1234`.