CodePron.Views.IndexItemBar = Backbone.View.extend({
  template: JST['previews/indexItemBar'],
  className: 'bars',

  render: function(){
    var content = this.template({preview: this.model})
    this.$el.html(content);

    return this;
  }
})
