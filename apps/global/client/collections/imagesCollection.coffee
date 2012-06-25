define [
  'backbone',
  'cs!image-model'
], (Backbone, ImageModel) ->
  ImagesCollection = Backbone.Collection.extend
   model: ImageModel
   url: "/instagram/media/search"
