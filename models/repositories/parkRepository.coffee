config      = require 'config'
mongoose    = require 'mongoose'

Park  = require('../park')

class ParkRepository
  constructor: ->
    mongoose.connect config.database.url
    @Park = mongoose.model 'Park', ParkSchema

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

  addImage: (park, image, callback) ->

module.exports = ParkRepository