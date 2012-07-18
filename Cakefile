fs                  = require 'fs'
config              = require 'config'
ParkRepository      = require './models/repositories/parkRepository'
ImageRepository     = require './models/repositories/imageRepository'
instagram           = require 'instagram-node-lib'

instagram.set 'client_id', config.instagram.client_id
instagram.set 'client_secret', config.instagram.client_secret

parkRepository = new ParkRepository()
imageRepository = new ImageRepository()


fetchImages = (park) ->    
  lat = park.lat.valueOf()
  lng = park.lng.valueOf()
  console.log 'park last updated', park.timeLastUpdated
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

task 'clear', 'clear images from all parks', ->
  parkRepository.all (err, parks) ->
    for park in parks
      parkRepository.removeImages park, (err) ->
        console.log 'park cleared'

task 'fetch', 'fetch images for all parks', ->
  parkRepository.all (err, parks) ->
    for park in parks
      fetchImages park

task 'resetLastUpdated', 'reset time last updated for parks', ->
  parkRepository.resetLastUpdated (err) ->
    console.log 'done'

task 'testInstagram', ->
  instagram.media.search
    lat: 36.698739
    lng: -99.14739
    distance: 5000
    min_timestamp: 1342586512
    complete: (data) ->
      console.log data
  # /v1/media/search?lat=36.698739&lng=-99.14739&distance=5000&max_timestamp=1342584804&client_id=b3481714257943a4974e4e7ba99eb357
  # /v1/media/search?distance=5000&lat=36.698739&lng=-99.14739&max_timestamp=&min_timestamp=0&client_id=b3481714257943a4974e4e7ba99eb357 


