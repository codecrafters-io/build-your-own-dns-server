The entry point for your DNS Server implementation is in `src/main/kotlin/Main.kt`.

Study and uncomment the relevant code: 

```kotlin
// Uncomment this block to pass the first stage

val udpSocket = java.net.DatagramSocket(2053)

while (true) {
  val buffer = ByteArray(512)
  val packet = java.net.DatagramPacket(buffer, buffer.size)
  udpSocket.receive(packet)
  println("Received data")

  val responseData = "hello world".toByteArray() // Dummy response, replace when implementing later stages
  val responsePacket = java.net.DatagramPacket(responseData, responseData.size, packet.address, packet.port)
  udpSocket.send(responsePacket)
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
