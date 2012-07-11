define [
  'backbone',
  'cs!../models/parkModel'
], (Backbone, ImageModel) ->
  ParksCollection = Backbone.Collection.extend
   url: "/api/parks"

