files = '

  fastdev
  compile
  build
  run
  install
  distribute

'.trim().split(/[^a-zA-Z\/\.]+/).map (s)-> './'+s

module.exports = (tintan)->

  require(file) tintan for file in files

  task 'tintan', ->
     console.log tintan.constructor.env
     console.log 'done'.green + ' building ' + tintan.constructor.appXML().name()
