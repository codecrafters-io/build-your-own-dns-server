const server: Deno.DatagramConn = Deno.listenDatagram({
    port: 2053,
    hostname: "127.0.0.1",
    transport: "udp"
});

for await (const [data, remoteAddr] of server) {
    const response = new TextEncoder().encode("");
    await server.send(response, remoteAddr);
}

// server.close();
