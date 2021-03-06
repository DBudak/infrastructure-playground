//setup
const express = require('express'),
  fetch = require('node-fetch'),
  app = express(),
  port = 3000;

app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
  res.setHeader('Access-Control-Allow-Credentials', true);
  next();
});

//add endpoint
app.get('/', (req, res) => {
  res.json({text: 'If you see this then I am working!'})
})

app.get('/service', (req, res) => {
  fetch(process.env.SERVER_URL).then( async (d) => {
    const resp = await d.json();
    res.json(resp); 
  }).catch(err => {
    res.json(err);
  })
})

//init server
app.listen(port, () => {
  console.log(`listening on ${port}`)
})
