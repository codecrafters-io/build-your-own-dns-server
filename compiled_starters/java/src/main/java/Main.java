import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class Main {
  public static void main(String[] args){
    // You can use print statements as follows for debugging, they'll be visible when running tests.
    System.out.println("Logs from your program will appear here!");

    // Uncomment this block to pass the first stage
    //
    // try(DatagramSocket serverSocket = new DatagramSocket(2053)) {
    //   while(true) {
    //     final byte[] buf = new byte[512];
    //     final DatagramPacket packet = new DatagramPacket(buf, buf.length);
    //     serverSocket.receive(packet);
    //     System.out.println("Received data");
    //
    //     final byte[] bufResponse = new byte[512];
    //     final DatagramPacket packetResponse = new DatagramPacket(bufResponse, bufResponse.length, packet.getSocketAddress());
    //     serverSocket.send(packetResponse);
    //   }
    // } catch (IOException e) {
    //     System.out.println("IOException: " + e.getMessage());
    // }
  }
}
