fs      = require 'fs'
path    = require 'path'
{spawn} = require 'child_process'
pkgJSON = JSON.parse fs.readFileSync path.join(__dirname, 'package.json'), 'utf-8'
files   = [
  'Jakefile.coffee'
, 'README.md'
, 'package.json'
, 'index.js'
, 'lib/**/*'
, 'etc/*'
, 'bin/*'
, 'pub/*'
]

new jake.PackageTask pkgJSON.name, pkgJSON.version, ->
  @packageFiles.include files
  @needTarGz = true

new jake.NpmPublishTask pkgJSON.name, files

desc 'Build coffee from src/ to lib/ with source maps'
task 'build', ->
  proc = spawn 'coffee', '--compile --map --output lib/ src/'.split ' '
  proc.stdout.on 'data', (data) -> console.log data.toString().trim()
  proc.stderr.on 'data', (data) -> console.log data.toString().trim()

task 'default', -> jake.showAllTaskDescriptions true

