window.PronTest = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Utils:{},
  initialize: function() {
    PronTest.previews = new PronTest.Collections.Previews();
    PronTest.previews.fetch();
    new PronTest.Routers.Previews({"$rootEl": $("#main")});
    
    Backbone.history.start();
  }
};

$(document).ready(function(){
  PronTest.initialize();
});
