The entry point for your dns implementation is in `src/main/java/Main.java`.

Study and uncomment the relevant code: 

```java
// Uncomment this block to pass the first stage

try(DatagramSocket serverSocket = new DatagramSocket(2053)) {
  while(true) {
    final byte[] buf = new byte[512];
    final DatagramPacket packet = new DatagramPacket(buf, buf.length);
    serverSocket.receive(packet);
    System.out.println("Received data");

    final byte[] bufResponse = new byte[512];
    final DatagramPacket packetResponse = new DatagramPacket(bufResponse, bufResponse.length, packet.getSocketAddress());
    serverSocket.send(packetResponse);
  }
} catch (IOException e) {
    System.out.println("IOException: " + e.getMessage());
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
