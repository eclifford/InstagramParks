Park    = require('../../models/park')
# ImageRepository   = require('../../models/repositories/imageRepository')
namespace         = require('express-namespace')

routes = (app) ->
  park = new Park();

  app.namespace '/admin', ->
    app.get '/', (req, res) ->
      res.render "#{__dirname}/views/index",
        title: "Admin View"  

    app.namespace '/parks', ->
      app.get '/', (req, res) ->
        park.all (err, parks) ->
          res.render "#{__dirname}/views/parks/index",
            title: 'Parks'
            parks: parks  

      app.get '/new', (req, res) ->
        res.render "#{__dirname}/views/parks/new",
          title: 'New Park'

      app.post '/new', (req, res) ->
        park.new req.body.park, (err, park) ->
          res.redirect '/admin/parks'

      app.get '/delete/:id', (req, res) ->
        park.remove req.params.id, (err) ->
          res.redirect '/admin/parks'   

      app.get '/edit/:id', (req, res) ->
        park = park.get req.params.id, (err, park) ->
          res.render "#{__dirname}/views/parks/edit",
            title: 'Edit Park',
            park: park

module.exports = routes


