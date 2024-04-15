The entry point for your dns implementation is in `app/server.rb`.

Study and uncomment the relevant code: 

```ruby
# Uncomment this block to pass the first stage

loop do
  begin
    data, (_, sender_port, _, sender_ip) = udp_socket.recvfrom(512)
    response = ''
    udp_socket.send(response, 0, sender_ip, sender_port)
  rescue => e
    puts "Error receiving data: #{e}"
    break
  end
end
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
