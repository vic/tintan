module.exports = (tintan)->
  Tintan = tintan.constructor

  namespace 'run', ->

    if Tintan.appXML().targets 'android'
      desc 'Run the application on Android emulator'
      task 'android', ->
        Tintan.$.tipy ['android', 'builder.py'], 'simulator',
           Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id(),
           Tintan.$.android_version(), 'WVGA800'

    if Tintan.appXML().targets 'ipad'
      desc 'Run the application on iPad emulator'
      task 'ipad', ->
        Tintan.$.tipy ['iphone', 'builder.py'], 'simulator',
           Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name(),
           'ipad', 'retina'

    if Tintan.appXML().targets 'iphone'
      desc 'Run the application on iPhone emulator'
      task 'iphone', ->
        Tintan.$.tipy ['iphone', 'builder.py'], 'simulator',
           Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name(),
           'iphone', 'retina'
