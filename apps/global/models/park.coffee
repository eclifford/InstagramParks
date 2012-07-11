mongoose    = require('mongoose')
Schema      = mongoose.Schema

ImageSchema = require('./image').ImageSchema

ParkSchema = new Schema
  id: Number,
  name: String,
  lng: Number,
  lat: Number,
  timeLastUpdated: Number,
  hours: String,
  address: String,
  images: [ImageSchema]


module.exports.ParkSchema = ParkSchema
