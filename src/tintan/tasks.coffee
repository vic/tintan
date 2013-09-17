files = '

  fastdev
  compile
  config
  build
  run
  install
  distribute

'.trim().split(/[^a-zA-Z\/\.]+/).map (s)-> './'+s

module.exports = (tintan)->

  require(file) tintan for file in files

  task 'showenv', ->
    console.log tintan.constructor.env

  # Called by the compiler plugin (plugin.py)
  task 'tintan', ['showenv', 'default'], ->
    console.log 'done'.green + ' building ' + tintan.constructor.appXML().name()
