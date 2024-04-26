import * as dgram from 'dgram';

const server: dgram.Socket = dgram.createSocket('udp4');

server.on('message', (data, remoteAddr) => {
    const response = Buffer.from('');
    server.send(response, remoteAddr.port, remoteAddr.address);
});

server.bind(2053, '127.0.0.1', () => {
    console.log('Server is running on port 2053');
});
