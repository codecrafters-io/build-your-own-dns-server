The entry point for your dns implementation is in `app/main.ts`.

Study and uncomment the relevant code: 

```typescript
// Uncomment this block to pass the first stage

server.bind(2053, '127.0.0.1', () => {
    console.log('Server is running on port 2053');
});
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
