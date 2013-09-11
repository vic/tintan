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


### SOME TASKS

```sh
  # Compile sources
  $ tintan compile

  # Watch and compile [Iced] CoffeeScript sources
  $ tintan compile:coffee:watch

  # Build and launch on Android Virtual Device
  $ tintan run:android

  # Build and launch on Android physical device
  $ tintan install:android

  # Build and launch on iPad simulator
  $ tintan run:ipad

  etc...
```


### CONFIG / ENVIRONMENT VARIABLES

```sh
  # Configure all available options.
  # Creates JSON text file ./tintan.config if not present.
  $ tintan config

  # Display options and settings.
  $ tintan config:display

  # Set option/value pairs.
  $ tintan config:set option=value [option=value...]

  # Reset option to default value.
  $ tintan config:set option=default
```

  Normally Tintan will try to guess your current environment setup, you can
  however force a particular setting by setting or exporting one of the following variables:

#### OPTIONS

##### **option** / **ENV_VAR** &bull; *type* &bull; `default value`

**verbose** &bull; *boolean* &bull; `true`

Verbose compiling?

**iced** &bull; *boolean* &bull; `false`

Compile with Iced CoffeeScript?

**compile_js** &bull; *boolean* &bull; `true`

For distribution builds, compile JS with Closure compiler? (Obfuscation can be bad for debugging.)

**debug** &bull; *boolean* &bull; `false`

Wait for debugger to attach?

**debug\_address** &bull; *String* &bull; `'127.0.0.1'`

IP Address for debugger connection

**debug\_port** &bull; *Number* &bull; `5858`

Port for debugger

**android\_avd** / **AVD** &bull; *String* &bull; `null`

The Android virtual device to use for development.

**android\_device** &bull; *String* &bull; `''`

The Android physical device to use for development.

**android\_sdk** / **ANDROID\_SDK** &bull; *String* &bull; Linux: `/opt/android-sdk`, Mac: the max value of `/usr/local/Cellar/android-sdk/*`, Windows: `C:\Program Files (x86)\Android\android-sdk`

The location of the Android development kit.

**keystore** &bull; *String* &bull; `null`

The location of the Android keystore with which to sign distribution builds.

**storepass** &bull; *String* &bull; `null`

The storepass for the Android keystore with which to sign distribution builds.

**key_alias** &bull; *String* &bull; `null`

The alias for the Android keystore with which to sign distribution builds.

**ios\_version** / **IOS\_VERSION** &bull; *String* &bull; max value of `~/Library/Application Support/iPhone Simulator/`

The version of iOS to target, eg. 5.0, 6.0

**ti\_home** / **TI\_HOME** &bull; *String* &bull; Linux: `~/.titanium`, Mac: `/Library/Application Support/Titanium`

The Titanium directory containing `mobilesdk/` subdir.

**ti\_platform** / **TI\_PLATFORM** &bull; *String* &bull; Linux: `'android'`, Mac: `'iphone'`

The platform for mobile development: `'android'`, `'iphone'`, `'mobileweb'`, `'module'`

**ti\_python** / **TI\_PYTHON** &bull; *String* &bull; the python found in `$PATH`

The python executable to run Titanium scripts.

**ti\_sdk** / **TI\_SDK** &bull; *String* &bull; `<sdk-version />` in `tiapp.xml`, or the greatest version installed on `$TI_HOME/mobilesdk`

The version of the Titanium SDK to use.
