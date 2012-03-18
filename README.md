# Tintan - Titanium development with style!

  A coffee-script based tool for adding coffee, bdd and node_modules to your Titanium development.

  <img src="https://github.com/vic/tintan/raw/master/pub/pachuco.png" title="¡Ya llegó su pachucote!" />

###  OVERVIEW

  Tintan integrates state of the art tools into your Titanium development.
  
  Featuring a ready to use setup for building projects with useful Jake tasks,
  being able to write applications in CofeeScript without having to worry about compiling them,
  managing your project dependencies using NPM and allowing to include node modules on your
  mobile application using ender.js


###  FEATURES

  * Painless installation and project setup.
  * Integrated build with Titanium Studio.
  * CLI (tasks) for when you feel more confortable building from the command line.
  * Allows you to write CoffeeScript sources and get them automatically compiled.
  * Integrate BDD to your development and ensure all tests succeed on production builds.
  * Include vendor node modules for using within your app by using ender.js 

### INSTALLATION

```sh
  $ npm install -g tintan

  # cd /your/titanium/project

  $ tintan

  # Get an overview of available tasks
  $ tintan -T
```

  
### ENVIRONMENT VARIABLES

  Normally Tintan will try to guess your current environment setup, you can
  however force a particular setting by exporting one of the following variables:

    TI_PLATFORM   - The platform for mobile development: 'android' or 'iphone'

                    By default if your OS is Linux, android will be used,
                    on Mac iphone will be selected by default.


    TI_HOME       - The Titanium directory containing mobilesdk/ subdir.

                    On Linux, ~/.titanium if found.
                    On Mac /Library/Application Support/Titanium


    TI_SDK        - The version of the Titanium SDK to use.

                    By default the greatest version installed on $TI_HOME/mobilesdk


    TI_PYTHON     - The python executable to run Titanium scripts.

                    By default the python found in PATH


    ANDROID_SDK   - The location of the Android development kit.

                    Default: none.


    AVD           - The Android virtual device to use for development.

                    Default: none.
