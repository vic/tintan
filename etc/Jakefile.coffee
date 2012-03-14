#!/usr/bin/env coffee

require('Tintan').global()


compile 'coffee', from: _('src/coffee'), ext: '.coffee'
compile 'clojure', from: _('src/clojure'), ext: '.clojure'
