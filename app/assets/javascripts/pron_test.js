window.CodePron = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Utils:{},
  initialize: function() {
    CodePron.previews = new CodePron.Collections.Previews();
    CodePron.previews.fetch();
    new CodePron.Routers.Previews({"$rootEl": $("#main")});
    
    Backbone.history.start();
  }
};

$(document).ready(function(){
  CodePron.initialize();
});
