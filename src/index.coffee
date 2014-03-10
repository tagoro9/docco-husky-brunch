sysPath = require 'path'
{ spawn } = require 'child_process'

module.exports = class DoccoRunner
	
	brunchPlugin: yes

	constructor: (@config) ->

	optimize: (params, callback) ->
		# Determine the platform the script is run
		windows = process.platform is 'win32'
		if windows is on then SLASH = "\\" else SLASH = "/"		
		command = "node_modules#{SLASH}.bin#{SLASH}docco-husky Cakefile *.coffee app"
		[cmd, args...] = command.split ' '
		if windows is on
			docco = spawn "cmd", ["/c", cmd].concat args
		else
			docco = spawn cmd, args
		docco.stdout.pipe process.stdout
		docco.stdout.pipe process.stdout
		# Kill the child process whenever the parent finishes
		process.on 'exit', -> docco.kill 'SIGHUP'			
