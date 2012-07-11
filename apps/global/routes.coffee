Instagram       = require 'instagram-node-lib'
Instagram.set 'client_id', 'b3481714257943a4974e4e7ba99eb357' 
Instagram.set 'client_secret', '424e2760ecfb4a6e9be301257d401a80'
mongoose        = require 'mongoose'

ParkSchema      = require('./models/park').ParkSchema
ImageSchema     = require('./models/image').ImageSchema

routes = (app) ->
  mongoose.connect 'mongodb://localhost/instagramparks'
  @Image = mongoose.model 'Image', ImageSchema
  @Park = mongoose.model 'Park', ParkSchema

  app.get '/', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: "Instagram Your Face"

  app.get '/instagram/media/search', (req, res) ->
    Instagram.media.popular
      complete: (data) ->
        mongoose.connect 'mongodb://localhost/instagramparks'
        @Image = mongoose.model 'Image', ImageSchema
        for item in data
          _image = new @Image()
          _image.url = item.images.low_resolution.url
          _image.save (err) ->

        res.json data

  app.get '/park/:id', (req, res) ->
    @Park.find({_id: req.params.id}, (err, park) ->
      res.json park
    )  

  app.get '/api/subscription', (req, res) ->
    res.send req.query["hub.challenge"]

  app.post '/api/subscription', (req, res) ->
    console.log 'POST: /api/subscription'
    console.log req.body

  app.get '/api/parks', (req, res) ->
    @Park.find {}, (err, park) ->
      res.json park


module.exports = routes

