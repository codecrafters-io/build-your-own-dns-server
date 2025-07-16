In this stage we will parse the DNS question section which has compressed the question label sequences. You will be sent multiple values in the question section and you have to parse the queries and respond with the same question section (no need for compression) in the response along with answers for them. As for the answer section, respond with an `A` record type for each question. The values for these A records can be anything of your choosing.

As we already know how the Question Section and Answer Section look like from the previous stages, we will just give high level details of the packet that you are sent and what the tester expects.

Here is what the tester will send you:

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

You don't need to compress your response. We will never ask you to do something that will overflow the buffer size restriction of UDP, so compressing your response packet is not something you have to worry about. Though if you like an extra challenge feel free to compress the DNS packet, the tester will work with it too.

The question type will always be `A` and the question class will always be `IN`.

[This section](https://www.rfc-editor.org/rfc/rfc1035#section-4.1.4) of the RFC covers how this compression works.