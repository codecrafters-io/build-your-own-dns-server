The entry point for your dns implementation is in `src/main/kotlin/Main.kt`.

Study and uncomment the relevant code: 

```kotlin
// Uncomment this block to pass the first stage

val udpSocket = java.net.DatagramSocket(2053)
val buffer = ByteArray(512)
val packet = java.net.DatagramPacket(buffer, buffer.size)
udpSocket.receive(packet)
println("Received packet: ${packet.data}")
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
