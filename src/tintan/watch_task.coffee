path     = require 'path'
jakeLib  = path.dirname require.resolve 'jake'
FileList = require("#{jakeLib}/file_list").FileList


WatchTask = (name, taskNames, definition) ->
  self = this

  @watchTasks = if Array.isArray(taskNames) then taskNames else [taskNames]
  @watchFiles = new FileList()
  @rootTask = task 'watchTasks', @watchTasks

  @watchFiles.include WatchTask.DEFAULT_INCLUDE_FILES
  @watchFiles.exclude WatchTask.DEFAULT_EXCLUDE_FILES

  definition.call this if typeof definition is 'function'

  desc 'Runs these tasks: ' + @watchTasks.join(', ')
  task name, ->
    console.log 'WatchTask started for: ' + self.watchTasks.join(', ')
    jake.watch '.', {includePattern: /.+/}, (filePath) ->
      shouldRun = self.watchFiles.toArray().some (item) -> item is filePath
      if shouldRun
        self.rootTask.reenable true
        self.rootTask.invoke()

WatchTask.DEFAULT_INCLUDE_FILES = [
 './**/*.coffee'
, './**/*.iced'
]

WatchTask.DEFAULT_EXCLUDE_FILES = [
  'node_modules/**'
, '.git/**'
]


exports.WatchTask = WatchTask