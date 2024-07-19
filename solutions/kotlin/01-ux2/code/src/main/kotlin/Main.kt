fun main(args: Array<String>) {
    val udpSocket = java.net.DatagramSocket(2053)
    val buffer = ByteArray(512)
    val packet = java.net.DatagramPacket(buffer, buffer.size)
    udpSocket.receive(packet)
    println("Received packet: ${packet.data}")
}
