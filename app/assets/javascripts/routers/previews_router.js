CodePron.Routers.Previews = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '':'previewsIndex',
    'previews/new': 'newPreview',
    'previews/:id':'previewShow',
    'users/:id':'userShow'
  },

  userShow: function(id){
    var user = CodePron.users.getOrFetch(id);
    var view = new CodePron.Views.UserShow({model: user, collection: user.previews()});
    this._swapView(view);
  },

  previewsIndex: function(){
    var view = new CodePron.Views.PreviewsIndex({collection:CodePron.previews})
    this._swapView(view);
  },
  previewShow: function (id){
    var preview = CodePron.previews.getOrFetch(id);
    var showView = new CodePron.Views.PreviewShow({model: preview});
    this._swapView(showView);
  },

  newPreview: function(){
    var preview = new CodePron.Models.Preview();
    preview.save({},{
      success: function(preview){
        Backbone.history.navigate('/previews/'+preview.get('id'), {trigger: true});
      }
    })
  },

  _swapView: function (view){
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
})
