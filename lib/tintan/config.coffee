module.exports = (tintan) ->
  Tintan = tintan.constructor

  config_options = []

  namespace 'config', ->
    if jake.program.taskNames[0].split(':').length < 2
      config_options.push('config:all')

    desc 'Initialize options to default values'
    task 'init', ->
      Tintan.config().init()

    desc 'Configure all options'
    task 'all', ->
      Tintan.config().promptForAll()

    desc 'Show value of all options'
    task 'display', ->
      Tintan.config().display()

    desc 'Set a particular value. Usage: config:set option=[value|default]'
    task 'set', ->
      Tintan.config().set(jake.program.envVars)

  desc 'Configure Tintan'
  task 'config', config_options
