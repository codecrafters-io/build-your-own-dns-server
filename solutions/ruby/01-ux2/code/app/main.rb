require "socket"

udp_socket = UDPSocket.new
udp_socket.bind("127.0.0.1", 2053)

loop do
  data, (_, sender_port, _, sender_ip) = udp_socket.recvfrom(512)
  response = ""
  udp_socket.send(response, 0, sender_ip, sender_port)
rescue => e
  puts "Error receiving data: #{e}"
  break
end
