CodePron.Views.commentForm = Backbone.View.extend({
  template: JST['commentForm'],

  render: function(){
    var content = this.template()
    this.$el.html(content);
    return this;
  }
})
