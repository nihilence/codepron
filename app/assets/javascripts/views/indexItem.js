CodePron.Views.IndexItem = Backbone.CompositeView.extend({
  template: JST['previews/indexItem'],
  className: 'iframe small',

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);

    return this;
  },


  renderBars: function(){
    var bar = new CodePron.Views.IndexItemBar({
      model: this.model
    });
    this.addSubview('#index-bar-'+ this.model.get('id'), bar);
  }

})
