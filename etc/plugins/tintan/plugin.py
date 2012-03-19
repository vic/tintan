#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Tintan compiler plugin.
# 

import os, sys, subprocess

try:
    import json
except:
    import simplejson as json

# The Titanium build scripts contain their own json library (Patrick Logan's),
# so we have to figure out which json functions to use.
to_json = None
if hasattr(json, 'dumps'):
	to_json = json.dumps
else:
	to_json = json.write

def compile(config):
        c = config.copy()
        c.pop('tiapp', '')
        c.pop('android_builder', '')
        c.pop('logger', '')
        project_dir = c.get('project_dir')
        
        tintan = os.path.join(project_dir, 'node_modules/tintan/bin/tintan')
        
	print "[INFO] Executing Tintan"
        print "       node", tintan, "-C", project_dir, 'tintan'

        proc = subprocess.Popen(['node', tintan, '-C', project_dir, 'tintan'],
                                env={'TINTAN': to_json(c)}, stderr = sys.stderr, stdout = sys.stdout)
        proc.communicate();
        ret = proc.wait()

        if ret != 0:
          raise Exception('Tintan terminated with exitcode: '+str(ret))

if __name__ == '__main__':
	proj_dir = None
	if len(sys.argv) < 2:
		proj_dir = os.getcwd()
	else:
		proj_dir = sys.argv[1]
	config = {'project_dir': proj_dir, 'cli': True, 'tiapp': None}
        compile(config)
                
