CodePron.Views.CommentForm = Backbone.View.extend({
  template: JST['comments/commentForm'],

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);
    return this;
  },

})
