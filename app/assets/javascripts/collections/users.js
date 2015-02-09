CodePron.Collections.Users = Backbone.Collection.extend({
  model: CodePron.Models.User,
  url: '/users',

  getOrFetch: function(id){
    var model = this.get(id);
    var users = this;

    if(model){
      model.fetch();
    } else {
      model = new CodePron.Models.User({id:id});
      model.fetch({
        success: function(){
          users.add(model);
        }
      });
    }

    return model;
  }
})
