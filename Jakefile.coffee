fs      = require 'fs'
path    = require 'path'
pkgJSON = JSON.parse fs.readFileSync path.join(__dirname, 'package.json'), 'utf-8'
files   = [
  'Jakefile.coffee'
, 'README.md'
, 'package.json'
, 'index.js'
, 'lib/*'
, 'etc/*'
, 'bin/*'
, 'pub/*'
]

new jake.PackageTask pkgJSON.name, pkgJSON.version, ->
  @packageFiles.include files
  @needTarGz = true

new jake.NpmPublishTask pkgJSON.name, files
