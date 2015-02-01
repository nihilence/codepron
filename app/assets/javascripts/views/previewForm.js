PronTest.Views.PreviewForm = Backbone.View.extend({
  template: JST['previews/form'],

  initialize: function(){
    this.listenTo(this.model, "sync", this.render);
  },

  render: function(){
    var renderedContent = this.template({preview: this.model});
    console.log(renderedContent);
    this.$el.html(renderedContent);
    return this;
  }
})
