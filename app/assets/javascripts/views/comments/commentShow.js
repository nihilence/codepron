CodePron.Views.previewComments = Backbone.View.extend({
  template: JST['comments/commentShow'],

  render: function(){
    var content = this.template({comment: this.model})
    this.$el.html(content);
    return this;
  }

})
