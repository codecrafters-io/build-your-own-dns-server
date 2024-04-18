const server: Deno.DatagramConn = Deno.listenDatagram({
    port: 2053,
    hostname: "127.0.0.1",
    transport: "udp"
});

// You can use print statements as follows for debugging, they'll be visible when running tests.
console.log("Logs from your program will appear here!");

// Uncomment this to pass the first stage
// for await (const [data, remoteAddr] of server) {
//     const response = new TextEncoder().encode("");
//     await server.send(response, remoteAddr);
// }

// server.close();
