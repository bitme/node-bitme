# bitme-rest-client

Communicate with [BitMe REST API](https://test.bitme.com/docs/rest).

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

## Testing

You may use the [testnet](https://test.bitme.com) API for development/testing 
purposes.

```js
var bitme = new BitMe('testnetkey', 'testnetsecret', true);
```
