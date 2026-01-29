const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
  res.send('Hello from the Node.js app deployed via AWS CI/CD pipeline! Hello from Ukraine!');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});