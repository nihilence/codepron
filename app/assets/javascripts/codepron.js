window.CodePron = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Utils:{},
  initialize: function() {
    CodePron.previews = new CodePron.Collections.Previews();
    CodePron.users = new CodePron.Collections.Users();
    CodePron.previews.fetch();
    CodePron.users.fetch();
    new CodePron.Routers.Previews({$rootEl: $("#main-content")});

    Backbone.history.start();
  }
};

$(document).ready(function(){
  CodePron.initialize();
});
