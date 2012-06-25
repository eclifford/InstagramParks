express = require("express")
coffee = require("coffee-script")

app = module.exports = express.createServer()


app.configure ->
  app.set "views", __dirname + "/apps/global/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use app.router
  app.use express.static(__dirname + "/public")
  app.use express.static(__dirname + "/apps")
  app.use require('connect-assets')(
    src: __dirname + "/apps"
  )

app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()

# Routes
require('./apps/global/routes')(app)
require('./apps/admin/routes')(app)

app.listen 3000, ->
  console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env