# This Jakefile was automatically created by Tintan. Edit to your hearts content.
# For more help on customizing Tintan see: http://github.com/vic/tintan

# Include Tintan tasks on this project.
tintan = require('tintan')

# Compile coffee-script sources from src/coffee
tintan.compile 'coffee'

# Make the default task depend on build.
task 'default', ['build']
