fsExtra = require 'fs-extra'
path = require 'path'
Promise = require 'bluebird'
_ = require 'lodash'
fs = require 'fs'
fsExtra = require 'fs-extra'
fsExtra = require 'fs-extra'
path = require 'path'
Promise = require 'bluebird'
_ = require 'lodash'
fs = require 'fs'
fsExtra = require 'fs-extra'
folder = __dirname + '/File-test/'
holiday = __dirname+ '/holidays.csv'
moment = require 'moment'
csv = require("fast-csv")
day = []

module.exports = 

  TimeStamp:()->
    dumdb_rgx = /aboss_.*_(.*).db/
    input_rgx = /input_(.*).tgz/
    output_rgx = /output_(.*).tgz/
    stream = fs.createReadStream(holiday)
    

    fs.readdir folder, (err, files) ->

      _.each files, (file) ->
        match =  input_rgx.exec(file) or output_rgx.exec(file) or  dumdb_rgx.exec(file)
        if match != null
          date = moment(match[1]).format("e")
          #not holiday
          if !(date ==  ('6' || '0'))
            csvStream = csv()
              .on "data", (data) ->
                dayOff = moment(data[7]).format("YYYYMMDD")
                if  dayOff == match[1]
                  console.log "notpass",match[1]
                
              .on "end",(w)  ->
                console.log "done" ,w
            console.log match[1]
            stream.pipe(csvStream)

        
