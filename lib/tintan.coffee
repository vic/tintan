require 'colors'
path       = require 'path'
fs         = require 'fs'
libxml     = require 'libxmljs'
spawn      = require('child_process').spawn

class $

  @mem = (fn) -> (args ...)->
    (arguments.callee['memo'] ||= {})[[].concat args] ||= fn.apply this, args

  @pathSearch = (bin, dirs = process.env.PATH.split(':')) ->
    return path.join(d, bin) for d in dirs when path.existsSync path.join(d, bin)

  @_: (pth) -> path.join(process.cwd(), pth)

  @E: (pth) -> path.join(__dirname, '../etc', pth)

  @pkg: JSON.parse fs.readFileSync path.join(__dirname, '../package.json'), 'utf-8'

  @main: -> require('./tintan/main') Tintan

  @tasks: -> require('./tintan/tasks') Tintan

  @home: @mem ->
     dirs = [  process.env.TI_HOME
       , '/Library/Application Support/Titanium'
       , path.join(process.env.HOME, 'Library/Application Support/Titanium')
       , path.join(process.env.HOME, '.titanium')
       ]
     return d for d in dirs when path.existsSync d

  @os: {
     'linux':  'linux'
     'darwin': 'osx'
     'win32':  'win'
    }[require('os').platform()]

  @platform: process.env.TI_PLATFORM || {osx: 'iphone'}[@os] || 'android'

  @sdk: @mem ->
     if path.existsSync process.env.TI_SDK
       process.env.TI_SDK
     else
       fs.readdirSync(path.join(@home(), 'mobilesdk', @os)).sort()[-1..][0]

  @tipy: @mem -> path.join(@home(), 'mobilesdk', @os, @sdk(), 'titanium.py')

  @py: @mem ->
     return py for py in [process.env.PYTHON, process.env.TI_PYTHON,
                          process.env.PYTHON_EXECUTABLE] when path.existsSync py
     @pathSearch 'python'

  @titan: (args ..., cb)->
    unless cb instanceof Function
      args.push cb
      cb = ->
    p = spawn @py(), [@tipy()].concat(args)
    p.stdout.on 'data', (data)-> process.stdout.write data
    p.stderr.on 'data', (data)-> process.stderr.write data
    p.on 'exit', cb

  @fastdev: (args ...)-> @titan.apply this, ['fastdev'].concat(args)

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
