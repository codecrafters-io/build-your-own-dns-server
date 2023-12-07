The entry point for your dns implementation is in `app/main.go`.

Study and uncomment the relevant code: 

```go
// Uncomment this block to pass the first stage
"net"
```

```go
// Uncomment this block to pass the first stage

udpAddr, err := net.ResolveUDPAddr("udp", "127.0.0.1:2053")
if err != nil {
	fmt.Println("Failed to resolve UDP address:", err)
	return
}

udpConn, err := net.ListenUDP("udp", udpAddr)
if err != nil {
	fmt.Println("Failed to bind to address:", err)
	return
}
defer udpConn.Close()

buf := make([]byte, 512)

for {
	size, source, err := udpConn.ReadFromUDP(buf)
	if err != nil {
		fmt.Println("Error receiving data:", err)
		break
	}

	receivedData := string(buf[:size])
	fmt.Printf("Received %d bytes from %s: %s\n", size, source, receivedData)

	// Create an empty response
	response := []byte{}

	_, err = udpConn.WriteToUDP(response, source)
	if err != nil {
		fmt.Println("Failed to send response:", err)
	}
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
