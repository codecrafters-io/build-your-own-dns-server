The entry point for your DNS Server implementation is in `src/main.zig`.

Study and uncomment the relevant code: 

```zig
// Uncomment this block to pass the first stage

var buf: [1024]u8 = undefined;
while (true) {
    var client_addr: posix.sockaddr = undefined;
    var client_addr_len: posix.socklen_t = @sizeOf(posix.sockaddr);

    _ = try posix.recvfrom(sock_fd, &buf, 0, &client_addr, &client_addr_len);

    const response: []const u8 = "";
    _ = try posix.sendto(sock_fd, response, 0, &client_addr, client_addr_len);
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
