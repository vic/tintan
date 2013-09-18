module.exports = (tintan)->
  Tintan = tintan.constructor

  namespace 'run', ->

    if Tintan.appXML().targets 'android'
      desc 'Run the Android emulator'
      task 'emulator', ->
        # default to config options unless supplied by environment vars
        android_avd = process.env.AVD
        android_avd or= Tintan.config().envOrGet('android_avd')

        Tintan.$.tipy ['android', 'builder.py'], 'emulator',
          Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id(),
          Tintan.$.android_version(), android_avd

    if Tintan.appXML().targets 'android'
      desc 'Run the application on Android emulator' # with debugging'
      task 'android', ['compile'], {async: true}, ->
        # default to config options unless supplied by environment vars
        conf = Tintan.config()
        android_avd = process.env.AVD
        android_avd or= conf.envOrGet('android_avd')

        if conf.envOrGet('debug') is true
          debug_string = conf.envOrGet('debug_address') + ':' + conf.envOrGet('debug_port')

          Tintan.$.tipy ['android', 'builder.py'], 'simulator',
            Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id(),
            Tintan.$.android_version(), android_avd, debug_string,
            complete
        else
          Tintan.$.tipy ['android', 'builder.py'], 'simulator',
            Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id(),
            Tintan.$.android_version(), android_avd,
            complete


    if Tintan.$.os is 'osx'
      if Tintan.appXML().targets 'ipad'
        desc 'Run the application on iPad emulator'
        task 'ipad', ['compile'], {async: true}, ->
          Tintan.$.tipy ['iphone', 'builder.py'], 'run',
            process.cwd(), Tintan.$.ios_version(), Tintan.appXML().id(), Tintan.appXML().name(),
            'ipad',
            complete

      if Tintan.appXML().targets 'iphone'
        desc 'Run the application on iPhone emulator'
        task 'iphone', ['compile'], {async: true}, ->
          Tintan.$.tipy ['iphone', 'builder.py'], 'run',
            process.cwd(), Tintan.$.ios_version(), Tintan.appXML().id(), Tintan.appXML().name(),
            'iphone',
            complete
