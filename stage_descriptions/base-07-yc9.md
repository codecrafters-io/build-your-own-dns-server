Your parser can read a name written as a sequence of labels. In this stage,
you'll parse compressed question names and return an A record for each question.

### Compressed names

DNS name compression avoids repeating the same labels within a message. A name
can contain labels, a pointer, or labels followed by a pointer.

A pointer occupies two bytes. Its two most significant bits are `11`, and the
remaining 14 bits give a zero-based offset from the start of the complete DNS
message. The bytes at that offset supply the rest of the name. Ordinary
label-length bytes have their first two bits set to `00` and allow labels of up
to 63 bytes.

For example, suppose `example.com` starts at byte offset `12`. The name
`www.example.com` can be encoded as:

```text
03 77 77 77 c0 0c
```

`03 77 77 77` represents the label `www`. `c0 0c` points to offset `12`, where
the remaining labels begin. A pointer ends the name at its current location, so
the question's type and class follow the pointer. No extra zero byte follows it
there. Decoding the name and locating the next field are distinct parts of
interpreting this representation.

### Tests

The tester starts `./your_program.sh` and sends a UDP query to port `2053` with
this structure:

```
| ------------------------------------------ |
| Header                                     |
| ------------------------------------------ |
| Question 1 (un-compressed label sequence)  |
| ------------------------------------------ |
| Question 2 (compressed label sequence)     |
| ------------------------------------------ |
```

What the tester expects in response:

```
| ------------------------------------------ |
| Header                                     |
| ------------------------------------------ |
| Question 1 (un-compressed label sequence)  |
| ------------------------------------------ |
| Question 2 (un-compressed label sequence)  |
| ------------------------------------------ |
| Answer 1 (un-compressed label sequence)    |
| ------------------------------------------ |
| Answer 2 (un-compressed label sequence)    |
| ------------------------------------------ |
```

Return the same questions in order and an A answer for each requested name.
Update `QDCOUNT` and `ANCOUNT` to match the entries. The diagrams show two
questions, including one compressed name.

You can still choose the IPv4 addresses in the answers.

Response compression is optional. The test messages are small enough for the
uncompressed response to fit the size limit used in this challenge. The tester
also accepts compressed responses.

The question type will always be `A` and the question class will always be `IN`.

Read the
[DNS message compression specification](https://www.rfc-editor.org/rfc/rfc1035#section-4.1.4)
for more detail.
