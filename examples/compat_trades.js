var BitBox = require('../lib/index');
var bitbox = new BitBox();

// get trades in the last 24-hours
bitbox.compatTrades('BTCUSD', function(err, trades) {
  if (err) return console.log(err);
  console.log(trades);
});
