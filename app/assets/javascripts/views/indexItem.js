CodePron.Views.IndexItem = Backbone.View.extend({
  template: JST['previews/indexItem'],
  className: 'iframe small',

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);
    return this;
  },


})
