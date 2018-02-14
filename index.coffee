_       = require 'lodash'
fs      = require 'fs'
moment  = require 'moment'
csv     = require "fast-csv" 

console.log "Hello World"
dumdb_rgx   = /aboss_.*_(.*).db/
input_rgx   = /input_(.*).tgz/
output_rgx  = /output_(.*).tgz/
holiday     = __dirname+ '/holidays.csv'

pathFolder = __dirname + "/backup/archived/trinity/"
folders   = ["db_dump", "input", "output"]
range     = ["20140101", "20201230" ]
arr       = []

create_log = (text, file)->
  content =  text + ": " + file + '\n'
  fs.appendFile "log.txt", content , (err) ->
    if err 
      throw err

_.each folders,(fd) ->
  path =  pathFolder + fd + '/' 
  fs.readdir path, (err, file) ->
    _.each file, (f)->
      match =  input_rgx.exec(f) or output_rgx.exec(f) or  dumdb_rgx.exec(f)
      if match != null
        date = moment(match[1]).format("e")
       #  # not saturday sunday
        if !(date ==   '6' || date ==  '0') 
          if moment(match[1]).isAfter(range[0]) and moment(match[1]).isBefore(range[1])
            csv
              .fromPath(holiday)
              .transform (data) ->
                moment(data[7]).format("YYYYMMDD")
              .on "data",(data)->
                unless (data == match[1])
                  arr.push match[1]
              .on "end", () ->
                sort =  _.uniq arr
                if sort.length 
                  content = "total : " + sort.length + " of folder  " + folders + '\n'
                  console.log content , sort
                  process.exit()
          else
            create_log("range time is incorrect ", match[0])
        else
          create_log("file is saturday or sunday ", match[0])
      else 
        create_log("file name is incorrect ",f)

