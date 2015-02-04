CodePron.Routers.Previews = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '':'previewsIndex',
    'previews/:id':'previewShow'
  },

  previewsIndex: function(){
    var view = new CodePron.Views.PreviewsIndex({collection:CodePron.previews})
    this._swapView(view);
  }
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
