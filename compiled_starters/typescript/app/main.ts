import * as dgram from "dgram";

// You can use print statements as follows for debugging, they'll be visible when running tests.
console.log("Logs from your program will appear here!");

// Uncomment this block to pass the first stage
//
// const udpSocket: dgram.Socket = dgram.createSocket("udp4");
// udpSocket.bind(2053, "127.0.0.1");
//
// udpSocket.on("message", (data: Buffer, remoteAddr: dgram.RemoteInfo) => {
//     try {
//         console.log(`Received data from ${remoteAddr.address}:${remoteAddr.port}`);
//         const response = Buffer.from("");
//         udpSocket.send(response, remoteAddr.port, remoteAddr.address);
//     } catch (e) {
//         console.log(`Error sending data: ${e}`);
//     }
// });
