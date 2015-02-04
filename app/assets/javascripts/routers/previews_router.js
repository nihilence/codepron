CodePron.Routers.Previews = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    'previews/:id':'previewShow'
  },

  previewShow: function (id){
    var preview = CodePron.previews.getOrFetch(id);
    var showView = new CodePron.Views.PreviewForm({model: preview});
    this._swapView(showView);
  },

  _swapView: function (view){
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
})
