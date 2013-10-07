var BitMe = require('../lib/index');
var bitme = new BitMe();

// get trades in the last 24-hours
bitme.compatTrades('BTCUSD', function(err, trades) {
  if (err) return console.log(err);
  console.log(trades);
});
