define [
  'backbone',
  'cs!images-collection',
  'cs!wall-view'
], (Backbone, ImagesCollection, WallView) ->
  GlobalRouter = Backbone.Router.extend
    routes: 
      'hello':         "hello",
      'tags/:tag':     "byTag",    #tags/tag
      'show/:id':      'show',
      '*path':         'defaultRoute'

    initialize: ->
      imagesCollection = new ImagesCollection()
      wallView = new WallView
        el: 'div#wall'
        collection: imagesCollection

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


