PronTest.Routers.Previews = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    'previews/:id':'previewShow'
  },

  previewShow: function (id){
    var preview = PronTest.previews.getOrFetch(id);
    var showView = new PronTest.Views.PreviewForm({model: preview});
    this._swapView(showView);
  },

  _swapView: function (view){
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
})
