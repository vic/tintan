module.exports = (tintan)->
  Tintan = tintan.constructor

  namespace 'install', ->

    if Tintan.appXML().targets 'android'
      desc 'Install the application on Android device'
      task 'android', ->
        Tintan.$.tipy ['android', 'builder.py'], 'install',
           Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id(),
           Tintan.$.android_version(), 'WVGA800'

    if Tintan.appXML().targets 'ipad'
      desc 'Install the application on iPad device'
      task 'ipad', ->
        Tintan.$.tipy ['iphone', 'builder.py'], 'install',
           Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name(),
           'ipad', 'retina'

    if Tintan.appXML().targets 'iphone'
      desc 'Install the application on iPhone device'
      task 'iphone', ->
        Tintan.$.tipy ['iphone', 'builder.py'], 'install',
           Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name(),
           'iphone', 'retina'
