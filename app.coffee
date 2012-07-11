express = require("express")
coffee = require("coffee-script")
cron = require("cron")

app = module.exports = express.createServer()


app.configure ->
  app.set "views", __dirname + "/apps/global/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use app.router
  app.use express.static(__dirname + "/public")
  app.use express.static(__dirname + "/apps")
  app.use require('connect-assets')(
    src: __dirname + "/apps"
  )

app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()

# Routes
require('./apps/global/routes')(app)
require('./apps/admin/routes')(app)

mongoose        = require 'mongoose'
Instagram       = require 'instagram-node-lib'
Instagram.set 'client_id', 'b3481714257943a4974e4e7ba99eb357' 
Instagram.set 'client_secret', '424e2760ecfb4a6e9be301257d401a80'
ParkSchema      = require('./models/park').ParkSchema
ImageSchema     = require('./models/image').ImageSchema

mongoose.connect 'mongodb://localhost/instagramparks'

cronJob = cron.CronJob
new cronJob("3 * * * * *", ->
  console.log 'fetching images'
  @Park = mongoose.model 'Park', ParkSchema
  @Image = mongoose.model 'Image', ImageSchema
  @Park.find({}, (err, parks) ->
    for park in parks
      fetchImages(park)
  )
, null, true, "America/Los_Angeles")  

fetchImages = (park) ->    
  lat = park.lat.valueOf()
  lng = park.lng.valueOf()
  Instagram.media.search
    lat: lat
    lng: lng
    radius: 5000
    complete: (data) ->
      for item in data
        if park.timeLastUpdated < item.created_time
          _image = new @Image()
          _image.url = item.images.low_resolution.url
          _image.time_stamp = item.created_time
          park.images.push _image
      park.timeLastUpdated = Math.round(new Date().getTime() / 1000)
      park.save (err) ->
        console.log 'park saved'

app.listen 3000, ->
  console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env