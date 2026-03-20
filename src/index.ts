const serve = Bun.serve({
  port: 3333,
  fetch(req) {
    return new Response('Hello World');
  },
});

console.log(`Server running at http://localhost:${serve.port}`);
