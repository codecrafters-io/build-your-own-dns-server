The entry point for your dns implementation is in `src/Server.cs`.

Study and uncomment the relevant code: 

```csharp
// Uncomment this block to pass the first stage
// Resolve UDP address
IPAddress ipAddress = IPAddress.Parse("127.0.0.1");
int port = 2053;
IPEndPoint udpEndPoint = new IPEndPoint(ipAddress, port);

// Create UDP socket
UdpClient udpClient = new UdpClient(udpEndPoint);

while (true)
{
    // Receive data
    IPEndPoint sourceEndPoint = new IPEndPoint(IPAddress.Any, 0);
    byte[] receivedData = udpClient.Receive(ref sourceEndPoint);
    string receivedString = Encoding.ASCII.GetString(receivedData);

    Console.WriteLine($"Received {receivedData.Length} bytes from {sourceEndPoint}: {receivedString}");

    // Create an empty response
    byte[] response = Encoding.ASCII.GetBytes("");

    // Send response
    udpClient.Send(response, response.Length, sourceEndPoint);
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
