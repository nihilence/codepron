CodePron.Collections.Comments = Backbone.Collection.extend({
  initialize: function(options){
    this.preview = options.preview
  },

  url: function(){
    return this.preview.url()+'/comments';
  },

  getOrFetch: function(id){
    var comment = this.get(id);
    var comments = this;
    if(!comment){
      comment = new Backbone.Models.Comment({id:id});
      comment.fetch({
        success: function(){
          comments.add(comment);
        }
      })
    } else {
      comment.fetch();
    }
    return comment;
  }

})
