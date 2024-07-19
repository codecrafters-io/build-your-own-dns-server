fun main(args: Array<String>) {
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
}
