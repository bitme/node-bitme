# bitme

Communicate with [BitMe REST API](http://bitme.github.io/rest/) using Node.js.

## Install

```
$ npm install bitme
```

## Verify API Credentials

```js
var BitMe = require('bitme');
var bitme = new BitMe('mykey', 'mysecret');

bitme.verifyCredentials(function(err, res) {
  if (err) return console.error(err);
  console.log('credentials are valid!');
});
```

## Orderbook

```js
// orderbook does not require authentication
var bitme = new BitMe();
bitme.orderbook('BTCLTC', function(err, res) {
  if (err) return console.error(err);
  console.log(res);
});
```
