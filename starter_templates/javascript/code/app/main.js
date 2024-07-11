const dgram = require("dgram");

// You can use print statements as follows for debugging, they'll be visible when running tests.
console.log("Logs from your program will appear here!");

// Uncomment this block to pass the first stage
//
// const udpSocket = dgram.createSocket("udp4");
// udpSocket.bind(2053, "127.0.0.1");
//
// udpSocket.on("message", (buf, rinfo) => {
//   try {
//     const response = Buffer.from("");
//     udpSocket.send(response, rinfo.port, rinfo.address);
//   } catch (e) {
//     console.log(`Error receiving data: ${e}`);
//   }
// });
//
// udpSocket.on("error", (err) => {
//   console.log(`Error: ${err}`);
// });
//
// udpSocket.on("listening", () => {
//   const address = udpSocket.address();
//   console.log(`Server listening ${address.address}:${address.port}`);
// });
