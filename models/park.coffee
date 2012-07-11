mongoose    = require('mongoose')
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

module.exports.ParkSchema = ParkSchema
