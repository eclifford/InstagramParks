cron              = require 'cron'
config            = require 'config'
instagram         = require 'instagram-node-lib'

ParkRepository    = require './models/repositories/parkRepository'
ImageRepository   = require './models/repositories/imageRepository'

parkRepository = new ParkRepository()
imageRepository = new ImageRepository()

console.log config.instagram.client_id

instagram.set 'client_id', config.instagram.cient_id
instagram.set 'client_secret', config.instagram.client_secret

Task = 
  start: ->
    that = @
    cronJob = cron.CronJob
    new cronJob("1 * * * * *", ->
      console.log 'starting job'

      parkRepository.all (err, parks) ->
        console.log parks
        for park in parks
          that.fetchImages park

    , null, true, "America/Los_Angeles")  

  fetchImages: (park) ->    
    console.log 'fetching images for park'
    lat = park.lat.valueOf()
    lng = park.lng.valueOf()
    instagram.media.search
      lat: lat
      lng: lng
      radius: 5000
      complete: (data) ->
        for item in data
          if park.timeLastUpdated < item.created_time
            image = 
              url: item.images.low_resolution.url
              time_stamp: item.created_time

            parkRepository.addImage park, image, ->

Task.start()




