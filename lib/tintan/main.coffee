path    = require 'path'
fs      = require 'fs'
jakeLib = path.dirname require.resolve 'jake'
jake    = require "#{jakeLib}/jake"
api     = require "#{jakeLib}/api"
utils   = require "#{jakeLib}/utils"
Program = require("#{jakeLib}/program").Program
Loader  = require("#{jakeLib}/loader").Loader
jakePkg = JSON.parse fs.readFileSync "#{jakeLib}/../package.json", 'utf-8'

jake.version = jakePkg.version

process.addListener 'uncaugthException', (err)-> program.handleErr err

global.jake = jake

args = process.argv.slice(2)
program = new Program()
program.parseArgs(args)

main = (Tintan)->

  jake.opts = program.opts

  jake[n] = v for own n, v of utils

  jake.FileList = require("#{jakeLib}/file_list").FileList
  jake.PackageTask = require("#{jakeLib}/file_list").PackageTask
  jake.NpmPublishTask = require("#{jakeLib}/file_list").NpmPublishTask

  process.env[n] = v for own n, v of jake.env
  process.chdir(jake.opts.directory) if jake.opts.directory

  global[n] = v for own n, v of api

  if process.env.TINTAN
    Tintan.env = JSON.parse(process.env.TINTAN)
  else
    Tintan.env = {}

  taskNames = program.taskNames

  # require('./build') Tintan
  boot = require('./boot') Tintan
  if boot.ready()
    loader = new Loader()
    loader.load(jake.opts.jakefile)
  else unless taskNames.length
    taskNames = ['boot:init']

  taskNames = taskNames.length and taskNames or ['default']
  api.task '__root__', taskNames, ->

  if jake.opts.tasks
    jake.showAllTaskDescriptions jake.opts.tasks
  else
    jake.Task['__root__'].invoke()

module.exports = program.preemptiveOption() and (->) or main
