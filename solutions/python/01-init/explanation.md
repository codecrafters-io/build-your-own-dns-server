The entry point for your dns implementation is in `app/main.py`.

Study and uncomment the relevant code: 

```python
# Uncomment this block to pass the first stage

udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
udp_socket.bind(("127.0.0.1", 2053))

while True:
    try:
        buf, source = udp_socket.recvfrom(512)

        response = b""

        udp_socket.sendto(response, source)
    except Exception as e:
        print(f"Error receiving data: {e}")
        break
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
