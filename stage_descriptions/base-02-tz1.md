All communications in the DNS protocol are carried in a single format called a "message". Each message consists of
5 sections: header, question, answer, authority, and an additional space.

In this stage, we'll focus on the "header" section. We'll look at the other sections in later stages.

### Header section structure

The header section of a DNS message contains the following fields: (we've also included the values that the tester expects in this stage)

| Field                             | Size    | Description                                                                                                            |
| ----------------------------------| ------- | ---------------------------------------------------------------------------------------------------------------------- |
| Packet Identifier (ID)            | 16 bits | A random ID assigned to query packets. Response packets must reply with the same ID. <br />**Expected value**: 1234.   |
| Query/Response Indicator (QR)     | 1 bit   | 1 for a reply packet, 0 for a question packet. <br />**Expected value**: 1.                                            |
| Operation Code (OPCODE)           | 4 bits  | Specifies the kind of query in a message. <br />**Expected value**: 0.                                                 |
| Authoritative Answer (AA)         | 1 bit   | 1 if the responding server "owns" the domain queried, i.e., it's authoritative. <br />**Expected value**: 0.           |
| Truncation (TC)                   | 1 bit   | 1 if the message is larger than 512 bytes. Always 0 in UDP responses. <br />**Expected value**: 0.                     |
| Recursion Desired (RD)            | 1 bit   | Sender sets this to 1 if the server should recursively resolve this query, 0 otherwise. <br />**Expected value**: 0.   |
| Recursion Available (RA)          | 1 bit   | Server sets this to 1 to indicate that recursion is available. <br />**Expected value**: 0.                            |
| Reserved (Z)                      | 3 bits  | Used by DNSSEC queries. At inception, it was reserved for future use. <br />**Expected value**: 0.                     |
| Response Code (RCODE)             | 4 bits  | Response code indicating the status of the response. <br />**Expected value**: 0 (no error).                           |
| Question Count (QDCOUNT)          | 16 bits | Number of questions in the Question section. <br />**Expected value**: 0.                                              |
| Answer Record Count (ANCOUNT)     | 16 bits | Number of records in the Answer section. <br />**Expected value**: 0.                                                  |
| Authority Record Count (NSCOUNT)  | 16 bits | Number of records in the Authority section. <br />**Expected value**: 0.                                               |
| Additional Record Count (ARCOUNT) | 16 bits | Number of records in the Additional section. <br />**Expected value**: 0.                                              |

The header section is always 12 bytes long. Integers are encoded in big-endian format.

You can read more about the full DNS packet format on [Wikipedia](https://en.wikipedia.org/wiki/Domain_Name_System#DNS_message_format), or
in [RFC 1035](https://tools.ietf.org/html/rfc1035#section-4.1). [This link](https://github.com/EmilHernvall/dnsguide/blob/b52da3b32b27c81e5c6729ac14fe01fef8b1b593/chapter1.md)
is a good tutorial that walks through the DNS packet format in detail.

---

Just like in the previous stage, the tester will execute your program like this:

```bash
./your_program.sh
```

It'll then send a UDP packet (containing a DNS query) to port 2053. Your program will need to respond with
a DNS reply packet that contains the header information described above.

We recommend creating an internal structure for a "DNS message" in your code, as we will build on this in later stages.

Note: The tester sends an extra packet at the start of testing each stage. You can ignore it.