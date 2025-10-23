const std = @import("std");
const net = std.net;
const posix = std.posix;

pub fn main() !void {
    const sock_fd = try posix.socket(posix.AF.INET, posix.SOCK.DGRAM, 0);
    defer posix.close(sock_fd);

    // Since the tester restarts your program quite often, setting SO_REUSEADDR
    // ensures that we don't run into 'Address already in use' errors
    const reuse: c_int = 1;
    try posix.setsockopt(sock_fd, posix.SOL.SOCKET, posix.SO.REUSEADDR, std.mem.asBytes(&reuse));

    const addr = net.Address.initIp4([4]u8{ 127, 0, 0, 1 }, 2053);
    try posix.bind(sock_fd, &addr.any, addr.getOsSockLen());

    // You can use print statements as follows for debugging, they'll be visible when running tests.
    std.debug.print("Logs from your program will appear here!\n", .{});

    // Uncomment the code below to pass the first stage
    //
    // var buf: [1024]u8 = undefined;
    // while (true) {
    //     var client_addr: posix.sockaddr = undefined;
    //     var client_addr_len: posix.socklen_t = @sizeOf(posix.sockaddr);
    //
    //     _ = try posix.recvfrom(sock_fd, &buf, 0, &client_addr, &client_addr_len);
    //
    //     const response: []const u8 = "";
    //     _ = try posix.sendto(sock_fd, response, 0, &client_addr, client_addr_len);
    // }
}
