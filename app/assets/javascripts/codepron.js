window.CodePron = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Utils:{},
  initialize: function() {
    CodePron.users = new CodePron.Collections.Users();
    CodePron.users.fetch({
      success: function(){
        console.log(CodePron.users);
      }
    });

    CodePron.previews = new CodePron.Collections.Previews();
    CodePron.previews.fetch(
    {
      success: function(){
        console.log(CodePron.users);
      }
    }
    );
    new CodePron.Routers.Previews({$rootEl: $("#main-content")});

    Backbone.history.start();
  }
};

$(document).ready(function(){
  CodePron.initialize();
});
