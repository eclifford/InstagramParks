cron              = require 'cron'
config            = require 'config'
instagram         = require 'instagram-node-lib'

ParkRepository    = require './models/repositories/parkRepository'
ImageRepository   = require './models/repositories/imageRepository'

parkRepository = new ParkRepository()
imageRepository = new ImageRepository()

instagram.set 'client_id', config.instagram.client_id
instagram.set 'client_secret', config.instagram.client_secret

Task = 
  start: ->
    that = @
    cronJob = cron.CronJob
    new cronJob("5 * * * * *", ->
      console.log 'starting job'

      parkRepository.all (err, parks) ->
        for park in parks
          that.fetchImages park

    , null, true, "America/Los_Angeles")  

  fetchImages: (park) ->    
    lat = park.lat.valueOf()
    lng = park.lng.valueOf()
    instagram.media.search
      lat: lat
      lng: lng
      distance: 5000
      min_timestamp: park.timeLastUpdated * 1 # Hack to convert to number
      complete: (data) ->
        for item in data
          image = 
            filter: item.filter
            tags: item.tags
            # caption: item.caption
            user: 
              username: item.user.username
              full_name: item.user.full_name
              profile_picture: item.user.profile_picture
              id: item.user.id
            created_time: item.created_time
            images:
              low_resolution: 
                url: item.images.low_resolution.url
              thumbnail: 
                url: item.images.thumbnail.url
              standard: 
                url: item.images.standard_resolution.url
            id: item.id
            location: item.location

          parkRepository.addImage park, image, (err) ->
            console.log 'image added:', image

Task.start()




