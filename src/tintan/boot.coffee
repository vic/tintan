require 'colors'
path = require 'path'
fs   = require 'fs'
eco  = require 'eco'
info = console.info
xtnd = require 'deep-extend'

{Tintan, $, _, E, appXML} = {}

T = (pth) ->
  T.deps.push _ pth

  file _(pth), ->
    info 'create'.green + ' ' + pth
    jake.mkdirP path.dirname @name
    temp = E pth + '.eco'
    if fs.existsSync temp
      temp = fs.readFileSync temp, 'utf-8'
      value = eco.render temp, Tintan: Tintan
      fs.writeFileSync @name, value, 'utf-8'
    else
      jake.cpR E(pth), @name

T.deps = []

npm_install = ->
  info 'updating'.green + ' node modules'
  npm = require('child_process').spawn 'npm', ['install', '-l']
  npm.stdout.on 'data', (data)-> process.stdout.write(data)
  npm.stderr.on 'data', (data)-> process.stderr.write(data)
  npm.on 'exit', (code)=>
    fail('npm install -l: failed with code '+code) if code != 0
    complete()

sublimeProject = (Tintan) ->
  cwd = process.cwd()
  file = Tintan.config().envOrGet 'sublime_project'
  file or= (f for f in fs.readdirSync(cwd) when /\.sublime-project$/.test f).sort()[0]
  file or= (cwd = cwd.split('/'))[cwd.length - 1] + ".sublime-project"

class Boot

  ready: ->
    files = ['package.json', 'Jakefile.coffee', 'plugins/tintan/plugin.py']
    return false for v in files when jake.Task['boot:'+_(v)].isNeeded()
    true

  constructor: (Ti)->

    Tintan = Ti
    appXML = Tintan.appXML()
    {$} = Tintan
    {E, _} = $
    plugin_py = 'plugins/tintan/plugin.py'

    namespace 'boot', ->

      T plugin_py

      desc 'Install the Tintan plugin for Titanium Studio'
      task 'plugin.py': _ plugin_py


      desc 'Register plugin on tiapp.xml'
      task 'plugin.xml', ->
        plugin = appXML.plugin()
        pluginVersion = plugin?.attr('version')?.value()
        unless pluginVersion is Tintan.version
          info 'register'.green + ' tintan plugin on tiapp.xml'
          xml = appXML.doc
          plugins = xml.get './plugins'
          unless plugins
            plugins = xml.root().node 'plugins', ''
          plugin ?= plugins.node 'plugin', 'tintan'
          plugin.attr version: Tintan.version
          xml.encoding 'utf-8'
          fs.writeFileSync appXML.file(), xml.toString(), 'utf-8'
      T.deps.push 'plugin.xml'

      T 'package.json'
      desc 'Create a generic package.json'
      task 'package.json': _ 'package.json'

      T 'Jakefile.coffee'
      desc 'Create a basic Jakefile'
      task 'Jakefile.coffee': _ 'Jakefile.coffee'

      T 'tintan.config'
      desc 'Create a default config file'
      task 'tintan.config': _ 'tintan.config'

      filename = sublimeProject Tintan
      desc 'Add Tintan build system to #{filename}'
      task 'sublime', ->
        tmpl = fs.readFileSync (E 'sublime-project.json.eco'), 'utf-8'
        value = eco.render tmpl, Tintan: Tintan
        if fs.existsSync filename
          info 'upgrading'.green + ' ' + filename
          value = JSON.parse value
          existing = JSON.parse(fs.readFileSync(filename, 'utf-8'))
          existing.build_systems = xtnd (existing.build_systems or {}), value.build_systems
          value = JSON.stringify(existing, undefined, 2)
        fs.writeFileSync filename, value, 'utf-8'
        Tintan.config().set sublime_project: filename
      T.deps.push 'sublime'

      desc 'Install node modules with npm'
      task 'npm', [_('package.json')], npm_install, async: true
      T.deps.push 'npm'

      desc 'Initialize this project to use Tintan'
      task 'init', T.deps, ->
        info 'Tintan initialized'.bold.italic
        info 'Take a look at your Jakefile.coffee'

    desc 'Upgrade node modules and Tintan plugin'
    task 'upgrade', ['boot:plugin.py','boot:plugin.xml', 'boot:sublime'], ->
      etc_plugin_py = E plugin_py
      file _(plugin_py), [etc_plugin_py], ->
        info 'upgrading'.green + ' ' + @name
        jake.cpR etc_plugin_py, @name

      task 'npm_update', [_('package.json')], ->
        info 'bumping tintan version in package.json to'.green + ' ' + Tintan.version
        package_json = fs.readFileSync _('package.json'), 'utf-8'
        package_json = JSON.parse package_json
        package_json.devDependencies.tintan = Tintan.version
        if (not package_json.repository) or package_json.repository is {}
          gitrepo = Tintan.$.gitrepo()
          info 'adding project git repo to package.json:'.green + ' ' + gitrepo.url
          package_json.repository = gitrepo
        package_json = JSON.stringify(package_json, undefined, 2)
        fs.writeFileSync _('package.json'), package_json, 'utf-8'
        invoke 'boot:npm'

      invoke _ plugin_py
      invoke 'npm_update'

      info 'upgrade complete'.green

module.exports = (Tintan)-> new Boot Tintan
