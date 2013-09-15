module.exports = (tintan)->

  Tintan = tintan.constructor

  fastdev = Tintan.$.fastdev

  if Tintan.appXML().targets 'android'

    namespace 'fastdev', ->

      desc 'Start fastdev server'
      task 'start', -> fastdev 'start'

      desc 'Stop fastdev server'
      task 'stop', -> fastdev 'stop'

      desc 'Get the status of the fastdev server'
      task 'status', -> fastdev 'status'

      desc 'Restart the app connected to this fastdev server'
      task 'restart', -> fastdev 'restart-app'

      desc 'Kill the app connected to this fastdev server'
      task 'kill', -> fastdev 'kill-app'