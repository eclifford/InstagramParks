# lng: -122.387866973877
# lat: 37.78265474565738


define [
  'underscore',
  'backbone',
  'cs!wall-item-view',
  'jquery',
  'jquery-masonry'
], (_, Backbone, WallItemView, $) ->
  WallView = Backbone.View.extend
    events: ->
      'click a': 'update'

    initialize: ->
      _.bindAll @, 'render', 'update'

    update: ->

      @collection.bind 'reset', @render
      @collection.fetch
        data: 
          lng: $('input#lng').val()
          lat: $('input#lat').val()   
          distance: 1000

    render: ->
      $('ul', @el).html ''
      _.each @collection.models, (item) ->
        @renderItem item
      , @

      container = $('ul')
      container.imagesLoaded ->
        container.masonry
          itemSelector: 'li'
          columWidth: 200
      @

    renderItem: (item) ->
      wallItemView = new WallItemView
        model: item
      $('ul', @el).append wallItemView.render().el

