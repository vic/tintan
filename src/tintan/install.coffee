module.exports = (tintan)->
  Tintan = tintan.constructor

  namespace 'install', ->

    if Tintan.appXML().targets 'android'
      desc 'Install the application on Android device'
      task 'android', {async: true}, ->
        # default to config options unless supplied by environment vars
        conf = Tintan.config()
        android_device = conf.envOrGet('android_device')

        if conf.envOrGet('debug') is true
          debug_string = conf.envOrGet('debug_address') + ':' + conf.envOrGet('debug_port')

          Tintan.$.tipy ['android', 'builder.py'], 'install',
            Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id(),
            Tintan.$.android_version(), android_device, debug_string,
            complete
        else
          Tintan.$.tipy ['android', 'builder.py'], 'install',
            Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id(),
            Tintan.$.android_version(), android_device,
            complete


    if Tintan.$.os is 'osx'
      if Tintan.appXML().targets 'ipad'
        desc 'Install the application on iPad device'
        task 'ipad', {async: true}, ->
          Tintan.$.tipy ['iphone', 'builder.py'], 'install',
            Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name(),
            'ipad', 'retina',
            complete

      if Tintan.appXML().targets 'iphone'
        desc 'Install the application on iPhone device'
        task 'iphone', {async: true}, ->
          Tintan.$.tipy ['iphone', 'builder.py'], 'install',
            Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name(),
            'iphone', 'retina',
            complete
