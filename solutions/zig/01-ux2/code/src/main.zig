const std = @import("std");
const net = std.Io.net;

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    const addr: net.IpAddress = .{ .ip4 = .{ .bytes = .{ 127, 0, 0, 1 }, .port = 2053 } };
    const sock = try addr.bind(io, .{ .mode = .dgram });
    defer sock.close(io);

    var buf: [1024]u8 = undefined;
    while (true) {
        const message = try sock.receive(io, &buf);

        const response: []const u8 = "";
        try sock.send(io, &message.from, response);
    }
}
