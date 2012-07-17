mongoose    = require 'mongoose'
config      = require 'config'
Schema      = mongoose.Schema

ImageSchema = require('./image').ImageSchema

ParkSchema = new Schema
  subscription: Number,
  name: String,
  lng: Number,
  lat: Number,
  description: String,
  hours: String,
  address: String,
  images: [ImageSchema]

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

module.exports.ParkSchema = ParkSchema
module.exports = Park
