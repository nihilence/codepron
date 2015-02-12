window.CodePron = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Utils:{},
  initialize: function() {
    CodePron.users = new CodePron.Collections.Users();
    CodePron.users.fetch();

    CodePron.previews = new CodePron.Collections.Previews();
    CodePron.previews.fetch( {data: { page:1 } });

    new CodePron.Routers.Previews({$rootEl: $("#main-content")});

    Backbone.history.start();
  }
};
