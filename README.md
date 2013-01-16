# bitme-rest-client

Communicate with [BitMe REST API](http://bitme.github.com/rest/).

## Install

```
$ npm install bitme-rest-client
```

## Verify API Credentials

```js
var BitMe = require('bitme-rest-client');
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
bitme.orderbook('BTCUSD', function(err, res) {
  if (err) return console.error(err);
  console.log(res);
});
```
