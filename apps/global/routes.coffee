Park  = require('../../models/park')

routes = (app) ->
  park = new Park()

  app.get '/', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: "Instagram Your Face"

  app.get '/park/:id', (req, res) ->
    park.get req.params.id, (err, park) ->
      res.json park

  app.get '/api/parks', (req, res) ->
    park.all (err, park) ->
      res.json park

module.exports = routes

