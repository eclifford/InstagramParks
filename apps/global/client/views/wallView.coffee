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
    initialize: ->
      _.bindAll @, 'render'
      @collection.bind 'reset', @render
      @collection.fetch()

    render: ->
      myOptions =
        center: new google.maps.LatLng(39.50, -98.35)
        zoom: 5
        mapTypeId: google.maps.MapTypeId.TERRAIN

      map = new google.maps.Map document.getElementById("map_canvas"), myOptions

      @collection.each (item, i) ->
        console.log item
        latLng = new google.maps.LatLng(item.get('lat').valueOf(), item.get('lng').valueOf())
        console.log latLng
        marker = new google.maps.Marker
          position: latLng
          map: map
          title: 'Testing'
          id: item.get('_id')

        google.maps.event.addListener marker, 'click', ->
          Backbone.history.navigate("park/#{marker.id}", {silent: true, trigger: true})
          #Backbone.history.navigate("#park/#{marker.id}", {trigger: true})
          #swindow.location.hash = "#park/#{marker.id}"
          #Backbone.navigate("park/#{item.id}", {trigger: true});
          false
      
      @


