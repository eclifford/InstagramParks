ParkRepository    = require '../../models/repositories/parkRepository'
namespace         = require 'express-namespace'

routes = (app) ->
  parkRepository = new ParkRepository()

  app.namespace '/admin', ->
    app.get '/', (req, res) ->
      res.render "#{__dirname}/views/index",
        title: "Admin View"  

    app.namespace '/parks', ->
      app.get '/', (req, res) ->
        parkRepository.all (err, parks) ->
          res.render "#{__dirname}/views/parks/index",
            title: 'Parks'
            parks: parks  

      app.get '/new', (req, res) ->
        res.render "#{__dirname}/views/parks/new",
          title: 'New Park'

      app.post '/new', (req, res) ->
        parkRepository.new req.body.park, (err, park) ->
          res.redirect '/admin/parks'

      app.get '/delete/:id', (req, res) ->
        parkRepository.remove req.params.id, (err) ->
          res.redirect '/admin/parks'   

      app.get '/edit/:id', (req, res) ->
        park = parkRepository.get req.params.id, (err, park) ->
          res.render "#{__dirname}/views/parks/edit",
            title: 'Edit Park',
            park: park

module.exports = routes


