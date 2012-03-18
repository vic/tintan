module.exports = (Tintan)->

  namespace 'fastdev', ->

    desc 'Start fastdev server'
    task 'start', -> Tintan.$.fastdev 'start'

    desc 'Stop fastdev server'
    task 'stop', -> Tintan.$.fastdev 'stop'

    desc 'Get the status of the fastdev server'
    task 'status', -> Tintan.$.fastdev 'status'

    desc 'Restart the app connected to this fastdev server'
    task 'restart', -> Tintan.$.fastdev 'restart-app'

    desc 'Kill the app connected to this fastdev server'
    task 'kill', -> Tintan.$.fastdev 'kill-app'

  namespace 'tintan', ->

    task 'build', ->
      console.log 'building '
