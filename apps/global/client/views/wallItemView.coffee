define [
  'underscore',
  'backbone',
  'jquery',
  'text!global/client/templates/wallItemTemplate.html'
], (_, Backbone, $, WallItemTemplate) ->
  WallItemView = Backbone.View.extend
    tagName: "li"
    #template: _.template(WallItemTemplate)
    
    events: ->
      'click img': 'onClick'

    onClick: ->
      alert 'clicked image'

    initialize: ->

    render: ->
      $(@el).html _.template(WallItemTemplate, @model.toJSON())
      @



