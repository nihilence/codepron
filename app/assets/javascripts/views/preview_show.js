CodePron.Views.PreviewShow = Backbone.View.extend({
  template: JST['previews/previewShow'],
  tagName: 'iframe',
  initialize: function(){
    this.listenTo(this.model, "change", this.render);
  },


  render: function(){
    var content = this.template({preview: this.model})
    this.$el.html(content);
    this.delegateEvents();
    return this;
  }


});
