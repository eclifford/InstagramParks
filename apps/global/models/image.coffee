mongoose    = require('mongoose')
Schema      = mongoose.Schema

ImageSchema = new Schema
  url: String
  time_stamp: Number

module.exports.ImageSchema = ImageSchema
