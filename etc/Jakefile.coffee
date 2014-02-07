# This Jakefile was automatically created by Tintan. Edit to your hearts content.
# For more help on customizing Tintan see: http://github.com/vic/tintan

# Include Tintan tasks on this project.
tintan = require('tintan')

# Enable coffee compiler on this project
tintan.compile 'coffee'
# Enable dependencies packages compiler on this project
tintan.compile 'node_modules'

# Make the default task show all tasks (like cake/Cakefiles)
task 'default', -> jake.showAllTaskDescriptions true
