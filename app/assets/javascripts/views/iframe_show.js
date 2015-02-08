CodePron.Views.IframeShow = Backbone.View.extend({
  template: JST['previews/indexItem'],
  className: 'iframe',

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);
    return this;
  }
})