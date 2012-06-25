(function() {
  require.config({
    paths: {
      'cs': '/js/vendor/require-cs-plugin',
      'text': '/js/vendor/require-text-plugin',
      'backbone': '/js/vendor/backbone-0.9.2.min',
      'underscore': '/js/vendor/underscore-1.3.3.min',
      'jquery': '/js/vendor/jquery-1.7.2.min',
      'image-model': '/global/client/models/imageModel',
      'images-collection': '/global/client/collections/imagesCollection',
      'wall-view': '/global/client/views/wallView',
      'wall-item-view': '/global/client/views/wallItemView',
      'jquery-masonry': '/js/vendor/jquery.masonry.min'
    },
    shim: {
      'backbone': {
        deps: ['underscore', 'jquery'],
        exports: 'Backbone'
      },
      'underscore': {
        deps: ['jquery'],
        exports: 'Underscore'
      }
    }
  });
}).call(this);
