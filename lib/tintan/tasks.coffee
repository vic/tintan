files = '

  fastdev
  compile

'.trim().split(/[^a-zA-Z\/\.]+/).map (s)-> './'+s

module.exports = (tintan)->

  require(file) tintan for file in files

  namespace 'tintan', ->

    task 'build', ->
      console.log 'building '
