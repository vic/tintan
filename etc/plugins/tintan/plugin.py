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
        c.pop('tiapp')
        project_dir = c.get('project_dir')
        
	print "[TINTAN] Executing `tintan:build` task on ", project_dir

        tintan = os.path.join(project_dir, 'node_modules/tintan/bin/tintan')

        proc = subprocess.Popen([tintan, '-C', project_dir, 'tintan:build'],
                                env={'TINTAN': to_json(c)})
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
                
    
