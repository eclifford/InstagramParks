mongoose    = require('mongoose')
Schema      = mongoose.Schema

ImageSchema = new Schema
  filter: String
  tags: [String]
  caption: String
  user: 
    username: String
    full_name: String
    profile_picture: String
    id: String
  created_time: Number
  images:
    low_resolution: 
      url: String
    thumbnail: 
      url: String
    standard: 
      url: String
  id: String
  location: String

module.exports = ImageSchema
