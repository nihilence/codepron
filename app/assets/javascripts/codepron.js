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
    CodePron.previews.fetch();

    // CodePron.follows = new CodePron.Collections.Follows();
    // CodePron.follows.fetch();
    new CodePron.Routers.Previews({$rootEl: $("#main-content")});

    Backbone.history.start();
  }
};
