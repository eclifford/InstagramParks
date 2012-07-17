config      = require 'config'
mongoose    = require 'mongoose'

ImageSchema  = require('../image')

class ParkRepository
  constructor: ->
    mongoose.connect config.database.url
    @Image = mongoose.model 'Image', ImageSchema

  all: (callback) ->
    @Park.find {}, (err, park) ->
      callback null, park

  get: (id, callback) ->
    @Park.find {_id: id}, (err, park) ->
      callback null, park

  remove: (id, callback) ->
    park = @get id, ->
      @Park.remove()
      callback null

  new: (park, callback) ->
    park = new @Park()
    park.name = park.name
    park.lng = park.lng
    park.lat = park.lat
    park.timeLastUpdated = 0
    park.address = '1234'
    park.save (err) ->
      callback err

module.exports = ParkRepository