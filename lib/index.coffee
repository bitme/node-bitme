{createHmac} = require 'crypto'
{stringify} = require 'querystring'
request = require 'request'

getReqHash = (data) ->
  hmac = createHmac 'sha512', new Buffer(@secret, 'base64')
  hmac.update stringify data
  return hmac.digest 'base64'

doRequest = (method, call, data, cb) ->
  options = 
    uri: "#{@baseUri}#{call}"
    method: method
    strictSSL: @strictSSL
    
  if @key and @secret
    options.headers = 
      'Rest-Key': @key
      'Rest-Sign': getReqHash.call @, data
      
  if method is 'get'
    options.qs = data
  else
    options.form = data
    
  request options, (err, res, body) ->
    return cb err if err
    try
      json = JSON.parse body
    catch e
      return cb new Error "Server returned malformed JSON with status code: #{res.statusCode}"
    if res.statusCode isnt 200
      if not json.error
        return cb new Error "Server failed to return error object with status code: #{res.statusCode}"
      err = new Error()
      err[key] = value for key, value of json.error
      return cb err
    cb null, json

class BitBox
  constructor: (@key = null, @secret = null) ->
    @baseUri = 'https://bitbox.mx/rest/'
    @nonce = Date.now()
    @strictSSL = true
    
    
  ##
  # Auth Not Required
  ##
  
  orderbook: (currencyPair, cb) ->
    currencyPair = encodeURIComponent currencyPair
    doRequest.call @, 'get', "orderbook/#{currencyPair}", null, cb
    
  compatOrderbook: (currencyPair, cb) ->
    currencyPair = encodeURIComponent currencyPair
    doRequest.call @, 'get', "compat/orderbook/#{currencyPair}", null, cb

  compatTrades: (currencyPair, since..., cb) ->
    data = if since.length then since: since[0] else null
    currencyPair = encodeURIComponent currencyPair
    doRequest.call @, 'get', "compat/trades/#{currencyPair}", data, cb
    
    
  ##
  # Auth Required
  ##
    
  verifyCredentials: (cb) ->
    data = nonce: @nonce++
    doRequest.call @, 'get', 'verify-credentials', data, cb
    
  accounts: (cb) ->
    data = nonce: @nonce++
    doRequest.call @, 'get', 'accounts', data, cb
    
  bitcoinAddress: (cb) ->
    data = nonce: @nonce++
    doRequest.call @, 'get', 'bitcoin-address', data, cb
  
  ordersOpen: (cb) ->
    data = nonce: @nonce++
    doRequest.call @, 'get', 'orders/open', data, cb
    
  orderCreate: (currencyPair, orderTypeCd, quantity, rate, cb) ->
    data =
      nonce: @nonce++
      currency_pair: currencyPair
      order_type_cd: orderTypeCd
      quantity: quantity
      rate: rate
    doRequest.call @, 'post', 'order/create', data, cb
    
  orderCancel: (uuid, cb) ->
    data = 
      nonce: @nonce++
      uuid: uuid
    doRequest.call @, 'post', 'order/cancel', data, cb
    
  orderGet: (uuid, cb) ->
    data = nonce: @nonce++
    uuid = encodeURIComponent uuid
    doRequest.call @, 'get', "order/#{uuid}", data, cb
    
  couponCreate: (currencyCd, amount, cb) ->
    data =
      nonce: @nonce++ 
      currency_cd: currencyCd
      amount: amount
    doRequest.call @, 'post', 'coupon/create', data, cb
    
  couponRedeem: (code, cb) ->
    data =
      nonce: @nonce++
      code: code
    doRequest.call @, 'post', 'coupon/redeem', data, cb
    
  couponCancel: (code, cb) ->
    data =
      nonce: @nonce++
      code: code
    doRequest.call @, 'post', 'coupon/cancel', data, cb
    
  transferUser: (toUserUuid, currencyCd, amount, cb) ->
    data =
      nonce: @nonce++
      to_user_uuid: toUserUuid
      currency_cd: currencyCd
      amount: amount
    doRequest.call @, 'post', 'transfer/user', data, cb
    
module.exports = BitBox
