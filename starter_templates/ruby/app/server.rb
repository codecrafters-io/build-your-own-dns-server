require "socket"

udp_socket = UDPSocket.new
udp_socket.bind("127.0.0.1", 2053)

# You can use print statements as follows for debugging, they'll be visible when running tests.
print("Logs from your program will appear here!")

# Uncomment this block to pass the first stage
#
# loop do
#   data, (_, sender_port, _, sender_ip) = udp_socket.recvfrom(512)
#   response = ""
#   udp_socket.send(response, 0, sender_ip, sender_port)
# rescue => e
#   puts "Error receiving data: #{e}"
#   break
# end
