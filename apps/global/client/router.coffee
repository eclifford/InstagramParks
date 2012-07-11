define [
  'underscore',
  'backbone',
  'jquery',
  'cs!./views/wallView',
  'cs!./views/mapView',
  'cs!./views/detailView',
  'cs!./collections/parksCollection',
  'cs!./models/parkModel'
], (_, Backbone, $, WallView, MapView, DetailView, ParksCollection, ParkModel) ->
  GlobalRouter = Backbone.Router.extend
    initialize: ->
      _.bindAll @, 'parkDetail'

      @parksCollection = new ParksCollection()
      mapView = new WallView
        el: 'div#map_canvas'
        collection: @parksCollection

    routes:
      "park/:id":      "parkDetail"


    parkDetail: (id) ->
      parkModel = new ParkModel()
      parkModel.url = "/park/#{id}"

      console.log 'parkModel', parkModel

      detailView = new DetailView
        el: 'div#overlay'
        model: parkModel

      parkModel.fetch()

      false







      # imagesCollection = new ImagesCollection()
      # wallView = new WallView
      #   el: 'div#wall'
      #   collection: imagesCollection


      # @postList = new App.Collections.Posts()
      # @postListView = new App.Views.PostListView(
      #   el: 'div#posts',
      #   collection: @postList
    #   )

      
    # show: (id) ->
    #   console.log 'show fired', id
    #   @postListView.displayComments = true
    #   @postList.fetch data:
    #     id: id

    # byTag: (tag) ->
    #   @postListView.displayComments = false
    #   @postList.fetch data: 
    #     tags: tag

    # defaultRoute: ->
    #   postList = new App.Collections.Posts()
    #   postListView = new App.Views.PostListView(
    #     el: 'div#posts',
    #     collection: postList
    #   )
    #   postList.fetch()

    #   tagList = new App.Collections.Tags()
    #   userTagListiew = new App.Views.TagListView(
    #     el: 'ul#popularTags',
    #     collection: tagList
    #   )
    #   tagList.fetch()


    #   # myTags = new App.Collections.MyTags()
    #   # userTagListiew = new App.Views.MyTagListView(
    #   #   el: 'ul#myTags',
    #   #   collection: myTags
    #   # )
    #   # myTags.fetch()


