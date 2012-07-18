config      = require 'config'
mongoose    = require 'mongoose'

ParkSchema  = require('../park')
ImageSchema = require '../image'

class ParkRepository

  constructor: ->
    mongoose.connect config.database.url
    @Park = mongoose.model 'Park', ParkSchema
    @Image = mongoose.model 'Image', ImageSchema

  all: (callback) ->
    @Park.find {}, (err, park) ->
      callback null, park

  get: (id, callback) ->
    @Park.find {_id: id}, (err, park) ->
      callback null, park

  remove: (id, callback) ->
    park = @get id, ->
      park.remove()
      callback null

  new: (park, callback) ->
    _park = new @Park()
    _park.name = park.name
    _park.lng = park.lng
    _park.lat = park.lat
    _park.timeLastUpdated = 0
    _park.address = '1234'
    _park.save (err) ->
      callback err, _park

  addImage: (park, image, callback) ->
    _image = new @Image()
    _image = image
    park.images.push _image
    park.timeLastUpdated = Math.round((new Date()).getTime() / 1000)
    park.save (err) ->
      callback err

  removeImages: (park, callback) ->
    console.log 'parkid', park.id
    @Park.findById park.id, (err, park) ->
      console.log park.images
      park.images = []
      park.save (err) ->
        callback err

  resetLastUpdated: (callback) ->

    query = @Park.find {}

    query.exec (err, parks) ->
      for park in parks
        #console.log park
        park.timeLastUpdated = 0
        park.save (err, data) ->
          console.log 'saved park', data, err


module.exports = ParkRepository