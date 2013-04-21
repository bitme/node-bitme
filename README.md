# bitbox-rest-client

Communicate with [BitBox REST API](http://inbitbox.github.io/rest/).

## Install

```
$ npm install bitbox-rest-client
```

## Verify API Credentials

```js
var BitBox = require('bitbox-rest-client');
var bitbox = new BitBox('mykey', 'mysecret');

bitbox.verifyCredentials(function(err, res) {
  if (err) return console.error(err);
  console.log('credentials are valid!');
});
```

## Orderbook

```js
// orderbook does not require authentication
var bitbox = new BitBox();
bitbox.orderbook('BTCUSD', function(err, res) {
  if (err) return console.error(err);
  console.log(res);
});
```
