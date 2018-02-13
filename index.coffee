_       = require 'lodash'
fs      = require 'fs'
moment  = require 'moment'
csv     = require "fast-csv" 

console.log "Hello World"
dumdb_rgx   = /aboss_.*_(.*).db/
input_rgx   = /input_(.*).tgz/
output_rgx  = /output_(.*).tgz/
holiday     = __dirname+ '/holidays.csv'


folders   = ["db_dump", "input", "output"]
range     = ["20140101", "20161230" ]
arr       = []
_.each folders,(fd) ->
  path =  __dirname + '/' + fd + '/' 
  fs.readdir path, (err, file) ->
    _.each file, (f)->
      match =  input_rgx.exec(f) or output_rgx.exec(f) or  dumdb_rgx.exec(f)
      if match != null
        date = moment(match[1]).format("e")
       #  # not saturday sunday
        if !(date ==   '6' || date ==  '0') 
          if moment(match[1]).isAfter(range[0]) and moment(match[1]).isBefore(range[1])
            console.log f
            # csv
            #   .fromPath(holiday)
            #   .transform (data) ->
            #     moment(data[7]).format("YYYYMMDD")
            #   .on "data",(data)->
            #     unless (data == match[1])
            #       arr.push match[0]
            #   .on "end", () ->
            #     sort =  _.sortedUniq arr
            #     console.log "done\n",sort

a = [1,2,3,4,5,5]
csv
  .fromPath(holiday)
  .on "data",(data)->
    _.each a , (o)->
      console.log data[6],data[7]
  .on "end", () ->
    console.log "done\n"
