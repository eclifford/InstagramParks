config      = require 'config'
mongoose    = require 'mongoose'

ImageSchema  = require('../image')

class ImageRepository
  constructor: ->
    mongoose.connect config.database.url
    @Image = mongoose.model 'Image', ImageSchema

  clear: (callback) ->
    @Image.find({}).remove()
    callback null


module.exports = ImageRepository