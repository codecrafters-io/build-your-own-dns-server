The entry point for your dns implementation is in `src/main.rs`.

Study and uncomment the relevant code: 

```rust
// Uncomment this block to pass the first stage
use std::net::UdpSocket;
```

```rust
// Uncomment this block to pass the first stage
let udp_socket = UdpSocket::bind("127.0.0.1:2053").expect("Failed to bind to address");
let mut buf = [0; 512];

loop {
    match udp_socket.recv_from(&mut buf) {
        Ok((size, source)) => {
            println!("Received {} bytes from {}", size, source);
            let response = [];
            udp_socket
                .send_to(&response, source)
                .expect("Failed to send response");
        }
        Err(e) => {
            eprintln!("Error receiving data: {}", e);
            break;
        }
    }
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
