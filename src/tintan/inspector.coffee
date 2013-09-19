fs      = require 'fs'
path    = require 'path'
{spawn} = require 'child_process'


module.exports = (tintan) ->
  Tintan = tintan.constructor
  pid = Tintan.$.E 'node-inspector.pid'
  running = fs.existsSync pid

  namespace 'inspector', ->
    task 'start', ->
      conf = Tintan.config()
      unless conf.envOrGet('debug') is true
        console.info 'debug is set to false, cannot start inspector'.red
        return

      debug_address = conf.envOrGet('debug_address')
      debug_port = conf.envOrGet('debug_port')
      debug_web_port = conf.envOrGet('debug_web_port')

      ni = "#{path.dirname require.resolve 'node-inspector'}/bin/inspector.js"
      p = spawn ni, ['--debug-port', debug_port,
                                   '--web-port',   debug_web_port,
                                   '--web-host',   debug_address],
                                   detached: true, stdio: [ 'ignore', 1, 2 ]

      fs.writeFileSync pid, p.pid, 'utf-8'
      p.unref()
      process.exit 0

    task 'stop', ->
      unless fs.existsSync pid
        console.info 'No inspector to kill'
        return

      num = fs.readFileSync pid, 'utf-8'
      try
        process.kill num
        console.info "node-inspector(#{num}) stopped"
      catch err
        console.info "unable to kill process #{num}"
      fs.unlink pid

    desc 'Restart node-inspector for Titanium' if running
    task 'restart', ['inspector:stop', 'inspector:start']


  if running then desc 'Stop node-inspector for Titanium'
  else desc 'Start node-inspector for Titanium'
  task 'inspector', [if running then 'inspector:stop' else 'inspector:start']
