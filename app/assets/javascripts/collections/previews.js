CodePron.Collections.Previews = Backbone.Collection.extend({
  url: 'api/previews',
  model: CodePron.Models.Preview,

  getOrFetch: function(id){
    var model = this.get(id);
    var previews = this;

    if(model){
      model.fetch();
    } else {
      model = new CodePron.Models.Preview({id:id});
      model.fetch({
        success: function(){
          previews.add(model);
        }
      });
    }

    return model;
  },


})
