module.exports = (tintan)->
  Tintan = tintan.constructor

  namespace 'distribute', ->

    if Tintan.appXML().targets 'android'
      desc 'Build final android distribution package for upload to marketplace'
      task 'android', ->
        Tintan.$.tipy ['android', 'builder.py'], 'distribute',
           Tintan.appXML().name(), Tintan.$.android_home(), process.cwd(), Tintan.appXML().id(),
           Tintan.$.android_version(), 'WVGA800'

    if Tintan.appXML().targets 'ipad'
      desc 'Build final ipad distribution package for upload to marketplace'
      task 'ipad', ->
        Tintan.$.tipy ['iphone', 'builder.py'], 'distribute',
           Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name(),
           'ipad', 'retina'

    if Tintan.appXML().targets 'iphone'
      desc 'Build final iphone distribution package for upload to marketplace'
      task 'iphone', ->
        Tintan.$.tipy ['iphone', 'builder.py'], 'distribute',
           Tintan.$.ios_version(), process.cwd(), Tintan.appXML().id(), Tintan.appXML().name(),
           'iphone', 'retina'
