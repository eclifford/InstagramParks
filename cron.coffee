# cron              = require 'cron'
# config            = require 'config'
# instagram         = require 'instagram-node-lib'

# ParkRepository    = require('./models/repositories/parkRepository')
# ImageRepository   = require('./models/repositories/imageRepository')

# parkRepository = new ParkRepository()
# imageRepository = new ImageRepository()

# Task = 
#   start: ->
#     cronJob = cron.CronJob
#     new cronJob("1 * * * * *", ->
#       console.log 'starting job'

#       parkRepository.all (err, parks) ->
#         console.log parks
#         for park in parks
#           fetchImages park

#     , null, true, "America/Los_Angeles")  

#   fetchImages: (park) ->    
#     console.log 'fetching images for park'
#     # lat = park.lat.valueOf()
#     # lng = park.lng.valueOf()
#     # Instagram.media.search
#     #   lat: lat
#     #   lng: lng
#     #   radius: 5000
#     #   complete: (data) ->
#     #     for item in data
#     #       if park.timeLastUpdated < item.created_time
#     #         _image = new @Image()
#     #         _image.url = item.images.low_resolution.url
#     #         _image.time_stamp = item.created_time
#     #         park.images.push _image
#     #     park.timeLastUpdated = Math.round(new Date().getTime() / 1000)
#     #     park.save (err) ->
#     #       console.log 'park saved'

# Task.start()




