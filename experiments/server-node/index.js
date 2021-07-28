//setup
const express = require('express'),
  app = express(),
  port = 3002;

app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
  res.setHeader('Access-Control-Allow-Credentials', true);
  next();
});

//add endpoint
app.get('/', (req, res) => {
  res.json(process.env)
})

//init server
app.listen(port, () => {
  console.log(`listening on ${port}`)
})
