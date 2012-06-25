routes = (app) ->
  app.get '/admin', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: "Admin View"

module.exports = routes
