files = '

  fastdev
  compile

'.trim().split(/[^a-zA-Z\/\.]+/).map (s)-> './'+s

module.exports = (tintan)->

  require(file) tintan for file in files

  namespace 'tintan', ->

    task 'build', ['^compile'], ->
      console.log 'done'.green + ' building ' + tintan.constructor.appXML.name()
