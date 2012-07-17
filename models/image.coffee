mongoose    = require('mongoose')
Schema      = mongoose.Schema

ImageSchema = new Schema
  url: String

module.exports = ImageSchema
