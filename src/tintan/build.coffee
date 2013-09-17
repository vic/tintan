module.exports = (tintan)->
  Tintan = tintan.constructor

  build_deps = []

  namespace 'build', ->

    if Tintan.$.os is 'osx' and Tintan.appXML().targets 'iphone'
      build_deps.push 'build:iphone'
      desc 'Build for iPhone'
      task 'iphone', ['compile'], {async: true}, ->
        Tintan.$.tipy ['iphone', 'builder.py'], 'build',
          Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name(),
          complete

    if Tintan.appXML().targets 'android'
      build_deps.push 'build:android'
      desc 'Build for Android'
      task 'android', ['compile'], {async: true}, ->
        Tintan.$.tipy ['android', 'builder.py'], 'build',
          Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id(),
          complete

  desc 'Build sources'
  task 'build', build_deps
