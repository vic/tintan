#!/usr/bin/env iced

# Complete jake tasks script for bash
# Save it somewhere and then add
# complete -C path/to/script -o default jake
# to your ~/.bashrc
# Bug-fix from Xavier Shay's version
# ported from Ruby/Rakefile version https://gist.github.com/cayblood/2499921
# to Node/IcedCoffee/Jakefile by doublerebel
# https://gist.github.com/doublerebel/6603667

fs     = require 'fs'
path   = require 'path'
util   = require 'util'
jake   = require 'jake'
{exec} = require('child_process')

RegExp.escape = (s) -> s.replace /[$-\/?[-^{|}]/g, '\\$&'


cache_dir = path.join process.env.HOME, '.jake', 'tc_cache'
JAKEFILES = [
  'Jakefile'
  'jakefile'
  'Jakefile.coffee'
  'jakefile.coffee'
  'Jakefile.js'
  'jakefile.js'
]

cwd = process.cwd()
cline = process.env.COMP_LINE
jakefile = do -> return jf for jf in JAKEFILES when fs.existsSync path.join cwd, jf
process.exit 0 unless jakefile or /^(jake|tintan)\b/.test cline

after_match = (cline.substr 4).trim()
task_match = after_match.split(" ")[-1..][0] unless after_match is ""

jake.mkdirP cache_dir
jakefile_path = path.join cwd, jakefile
cache_file = path.join cache_dir, (jakefile_path.replace /\//g, '_')

if (fs.existsSync cache_file) and (fs.statSync cache_file).mtime.getTime() >= (fs.statSync jakefile).mtime.getTime()
  # File.mtime( cache_file ) >= (Dir['lib/tasks/*.rake'] << jakefile).collect {|x| File.mtime(x) }.max
  task_lines = fs.readFileSync cache_file, 'utf-8'
else
  await exec 'jake --tasks 2>/dev/null', defer err, task_lines
  fs.writeFileSync cache_file, task_lines, 'utf-8'


task_lines = task_lines.replace /.\[([0-9]{1,2}([0-9]{1,2})?)?[m|K]/g, ''
tasks = (line.split(/\s/)[1] for line in task_lines.split("\n") when /\s/.test line)
tasks = (task for task in tasks when (new RegExp "^#{RegExp.escape task_match}").test task) if task_match

# handle namespaces
if match = task_match?.match /^([-\w:]+:)/
  upto_last_colon = match[0]
  after_match = task_match.split(":")
  after_match.shift()
  after_match.join "\n"
  tasks = for task in tasks
    if match = task.match (new RegExp "^#{RegExp.escape upto_last_colon}([-\\w:]+)$")
      match[1]
    else task
util.puts tasks.join "\n"

process.exit 0