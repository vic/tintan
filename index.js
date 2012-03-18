require('coffee-script')

var Tintan = require('./lib/tintan') 
  , tintan = new Tintan

Tintan.$.tasks(tintan)

module.exports = tintan
