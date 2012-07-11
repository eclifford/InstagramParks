define [
  'underscore',
  'backbone',
  'jquery'
], (_, Backbone, $) ->
  MapView = Backbone.View.extend
    initialize: ->
      console.log _.bindAll
      _.bindAll @, 'render',
      @collection.bind 'reset', @render
      @collection.fetch()

    render: ->
      console.log @ 
      console.log @collection
      for item in @collection.models
        console.log item
      # Add markers to map




