// Generated by CoffeeScript 1.6.3
(function() {
  var FileList, WatchTask, jakeLib, path;

  path = require('path');

  jakeLib = path.dirname(require.resolve('jake'));

  FileList = require("" + jakeLib + "/file_list").FileList;

  WatchTask = function(name, taskNames, definition) {
    var self;
    self = this;
    this.watchTasks = Array.isArray(taskNames) ? taskNames : [taskNames];
    this.watchFiles = new FileList();
    this.rootTask = task('watchTasks', this.watchTasks);
    this.watchFiles.include(WatchTask.DEFAULT_INCLUDE_FILES);
    this.watchFiles.exclude(WatchTask.DEFAULT_EXCLUDE_FILES);
    if (typeof definition === 'function') {
      definition.call(this);
    }
    desc('Runs these tasks: ' + this.watchTasks.join(', '));
    return task(name, function() {
      console.log('WatchTask started for: ' + self.watchTasks.join(', '));
      return jake.watch('.', {
        includePattern: /.+/
      }, function(filePath) {
        var shouldRun;
        shouldRun = self.watchFiles.toArray().some(function(item) {
          return item === filePath;
        });
        if (shouldRun) {
          self.rootTask.reenable(true);
          return self.rootTask.invoke();
        }
      });
    });
  };

  WatchTask.DEFAULT_INCLUDE_FILES = ['./**/*.coffee', './**/*.iced'];

  WatchTask.DEFAULT_EXCLUDE_FILES = ['node_modules/**', '.git/**'];

  exports.WatchTask = WatchTask;

}).call(this);

/*
//@ sourceMappingURL=watch_task.map
*/