CodePron.Views.CommentShow = Backbone.View.extend({
  template: JST['comments/commentShow'],

  initialize: function(options){
    this.preview = options.preview;
  },

  render: function(){
    var content = this.template({comment: this.model, preview: this.preview})
    this.$el.html(content);
    return this;
  }

})
