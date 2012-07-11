

define [
  'underscore',
  'backbone',
  'jquery',
  'text!global/client/templates/detailViewTemplate.html'
], (_, Backbone, $, DetailViewTemplate) ->
  DetailView = Backbone.View.extend
    initialize: ->
      console.log 'initialize'
      _.bindAll @, 'render'
      @model.bind('change', @render)
    
    render: ->
      console.log @model, 'model'
      $(@el).html _.template(DetailViewTemplate, @model.get(0))
      
      @


