#!/usr/bin/env coffee
somata = require 'somata'
SomataPipeline = require './pipeline'
fs = require 'fs'
argv = require('yargs').argv

client = new somata.Client

# Set up a readline prompt
PipelineREPL = require 'hashpipe/lib/repl'

pipe = new SomataPipeline({client: client})
    .use('http')
    .use('encodings')

repl = new PipelineREPL(pipe)

runWith = (repl, script, cb) ->
    doRunWith = ->
        repl.executeScript script, ->
            cb?() || process.exit()
    if !process.stdin.isTTY
        piped = ''
        process.stdin.on 'data', (data) ->
            piped += data.toString()
        process.stdin.on 'end', ->
            repl.last_out = piped.trim()
            doRunWith()
    else
        setTimeout doRunWith, 500

if script_filename = argv.load || argv.l
    # Execute single script
    console.log "Reading from #{ script_filename }..."
    script = fs.readFileSync(script_filename).toString()
    runWith repl, script, ->
        repl.startReadline()

else if script_filename = argv.run || argv.r
    script = fs.readFileSync(script_filename).toString()
    runWith repl, script

else if script = argv.exec || argv.e
    repl.plain = true
    runWith repl, script

else
    repl.startReadline()

