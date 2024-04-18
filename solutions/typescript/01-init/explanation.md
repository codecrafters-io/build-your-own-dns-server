The entry point for your dns implementation is in `app/main.ts`.

Study and uncomment the relevant code: 

```typescript
// Uncomment this to pass the first stage
for await (const [data, remoteAddr] of server) {
    const response = new TextEncoder().encode("");
    await server.send(response, remoteAddr);
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
