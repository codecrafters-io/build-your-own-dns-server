In this stage, you will implement a forwarding DNS server.

A forwarding DNS server, also known as a DNS forwarder, is a DNS server that is configured to pass DNS queries it receives from clients to another DNS server for resolution. Instead of directly resolving DNS queries by looking up the information in its own local cache or authoritative records.

---
In this stage the tester will execute your program like this:

```bash
./your_server --resolver <address>
```
* where `<address>` will be of the form `<ip>:<port>`

It'll then send a UDP packet (containing a DNS query) to port 2053. Your program will be responsible for forwarding DNS queries to a specified DNS server, and then returning the response to the original requester (i.e. the tester).

Your program will need to respond with a DNS reply packet that contains:
- a header section (same as in stage #5)
- a question section (same as in stage #6)
- an answer section (new in this stage) mimicing what you received from the DNS server to which you forwarded the request.

Here are a few assumptions you can make about the tester -
* It will always send you queries for `A` record type. So your parsing logic only needs to take care of this.

Here are few assumptions you can make about the DNS server you are forwarding the requests to -
* It will always respond with an answer section for the queries that originate from the tester.
* It will not contain other sections like (authority section and additional section)
* It will only respond when there is only one question in the question section. If you send multiple questions in the question section, it will not respond at all. So when you receive multiple questions in the question section you will need to split it into two DNS packets and then send them to this resolver then merge the response in a single packet.

Remember to mimic the packet identifier value sent by the tester in your response.