module.exports = (tintan)->
  Tintan = tintan.constructor

  build_deps = []

  namespace 'build', ->

    if Tintan.appXML().targets 'iphone'
      build_deps.push 'build:iphone'
      desc 'Build for iPhone'
      task 'iphone', ->
        Tintan.$.tipy ['iphone', 'builder.py'], 'build',
          Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name()

    if Tintan.appXML().targets 'android'
      build_deps.push 'build:android'
      desc 'Build for Android'
      task 'android', ->
        Tintan.$.tipy ['android', 'builder.py'], 'build',
          Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id()

  desc 'Build sources'
  task 'build', build_deps
