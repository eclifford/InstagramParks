mongoose        = require 'mongoose'
Instagram       = require 'instagram-node-lib'
Instagram.set 'client_id', 'b3481714257943a4974e4e7ba99eb357' 
Instagram.set 'client_secret', '424e2760ecfb4a6e9be301257d401a80'
ParkSchema      = require('../../models/park').ParkSchema
ImageSchema     = require('../../models/image').ImageSchema

routes = (app) ->
  mongoose.connect 'mongodb://localhost/instagramparks'
  @Park = mongoose.model 'Park', ParkSchema
  @Image = mongoose.model 'Image', ImageSchema

  app.get '/admin', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: "Admin View"

  app.get '/admin/parks', (req, res) -> 
    @Park.find({}, (err, parks) ->
      res.render "#{__dirname}/views/parks/index",
        title: 'Parks'
        parks: parks
    )

  app.get '/admin/parks/new', (req, res) ->
    res.render "#{__dirname}/views/parks/new",
      title: 'New Park'

  app.get '/admin/parks/delete/:id', (req, res) ->
    @Park.find({_id: req.params.id}).remove()
    res.redirect '/admin/parks'   


  app.post '/admin/parks/new', (req, res) ->
    _park = new @Park()
    _park.name = req.body.park.name
    _park.lng = req.body.park.lng
    _park.lat = req.body.park.lat
    _park.timeLastUpdated = 0
    _park.address = '1234'
    _park.save (err) ->
      res.redirect('/admin/parks')

  app.get '/admin/parks/subscribe', (req, res) ->
    # For each park
    # subscribe through instagram
    # update park with object_id(geography)
    @Park = mongoose.model 'Park', ParkSchema
    @Image = mongoose.model 'Image', ImageSchema
    @Park.find({}, (err, parks) ->
      for park in parks
        fetchImages(park)
    )
    res.send('done')

  fetchImages = (park) ->    
    lat = park.lat.valueOf()
    lng = park.lng.valueOf()
    Instagram.media.search
      lat: lat
      lng: lng
      radius: 5000
      min_timestamp: park.timeLastUpdated
      complete: (data) ->
        for item in data
          if park.timeLastUpdated < item.created_time
            _image = new @Image()
            _image.url = item.images.low_resolution.url
            _image.time_stamp = item.created_time
            park.images.push _image
        park.timeLastUpdated = Math.round(new Date().getTime() / 1000)
        park.save (err) ->
          console.log 'park saved'


  app.get '/admin/parks/unsubscribeall', (req, res) ->
    Instagram.media.unsubscribe_all()

  app.get '/admin/parks/subscribe/update', (req, res) ->
    res.send req.query["hub.challenge"]

  app.post '/admin/parks/subscribe/update', (req, res) ->
    if req.query._id is not undefined 
      @Park.find({_id: req.query._id}, (err, park) ->
        park.subscription = req.body.id
        park.save()
      )

  app.get '/admin/parks/:id', (req, res) ->    
    @Park.find({_id: req.params.id}, (err, park) ->
      res.render "#{__dirname}/views/parks/edit",
        title: 'Edit Park',
        park: park
    ) 

module.exports = routes


