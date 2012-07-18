mongoose    = require 'mongoose'
config      = require 'config'
Schema      = mongoose.Schema

ImageSchema = require('./image')

ParkSchema = new Schema
  name: String,
  lng: Number,
  lat: Number,
  description: String,
  hours: String,
  address: String,
  images: [ImageSchema]
  timeLastUpdated: Number
  # comments: [CommentSchema]

module.exports = ParkSchema
