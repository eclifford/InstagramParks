ParkRepository  = require '../../models/repositories/parkRepository'

routes = (app) ->
  parkRepository = new ParkRepository()

  app.get '/', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: "Instagram Your Face"

  app.get '/park/:id', (req, res) ->
    parkRepository.get req.params.id, (err, park) ->
      res.json park

  app.get '/api/parks', (req, res) ->
    parkRepository.all (err, park) ->
      res.json park

module.exports = routes

