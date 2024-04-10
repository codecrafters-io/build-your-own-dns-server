require 'socket'

def start_server
  udp_socket = UDPSocket.new
  udp_socket.bind('127.0.0.1', 2053)

  loop do
    begin
      buf, source = udp_socket.recvfrom(512)
      response = ''
      udp_socket.send(response, 0, source[3], source[1])
    rescue => e
      puts "Error receiving data: #{e}"
      break
    end
  end
end

start_server
