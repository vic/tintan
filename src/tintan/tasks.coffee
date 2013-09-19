files = '

  fastdev
  compile
  config
  build
  run
  install
  distribute
  inspector

'.trim().split(/[^a-zA-Z\/\.]+/).map (s)-> './'+s


module.exports = (tintan)->

  require(file) tintan for file in files

  env = tintan.constructor.env
  prereq = switch env?.command
    when 'distribute' then 'compile:dist'
    else 'compile'

  task 'showenv', -> console.log env

  # Called by the compiler plugin (plugin.py)
  task 'tintan', ['showenv', prereq], ->
    console.log 'done'.green + ' building ' + tintan.constructor.appXML().name()
