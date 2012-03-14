require 'colors'
path       = require 'path'
fs         = require 'fs'
libxml     = require 'libxmljs'

class $

  @_: (pth) -> path.join(process.cwd(), pth)

  @E: (pth) -> path.join(__dirname, '../etc', pth)

  @pkg: JSON.parse fs.readFileSync path.join(__dirname, '../package.json'), 'utf-8'

  @main: -> require('./tintan/main') Tintan


class AppXML

  file: $._('tiapp.xml')
  exist: -> path.existsSync @file

  constructor: ->
    throw "Missing Titanium file #{@file}".red unless @exist()
    @doc = libxml.parseXmlString fs.readFileSync @file, 'utf-8'

  plugin: -> @doc.get "./plugins/plugin[contains(text(),'tintan')]"

  name: -> @doc.get('./name').text()

  version: ->
    v = @doc.get('./version').text()
    v = v.split '.'
    if v.length < 3
      v = v.concat('0' for i in [0 .. (2 - v.length)])
    v.join '.'

class Tintan

  @$ = $
  @version: $.pkg.version
  @appXML = new AppXML


module.exports = Tintan
