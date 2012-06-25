Instagram = require 'instagram-node-lib'
Instagram.set 'client_id', 'b3481714257943a4974e4e7ba99eb357' 
Instagram.set 'client_secret', '424e2760ecfb4a6e9be301257d401a80'

routes = (app) ->
  app.get '/', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: "Instagram Your Face"

  app.get '/instagram/media/search', (req, res) ->

    Instagram.media.search
      lng: req.param('lng')
      lat: req.param('lat')
      complete: (data) ->
        res.json data

  # app.post '/instagram/update', (req, res) ->
    

module.exports = routes
