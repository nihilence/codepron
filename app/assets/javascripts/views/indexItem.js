CodePron.Views.IndexItem = Backbone.CompositeView.extend({
  template: JST['previews/indexItem'],
  className: 'iframe small',

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);
    var link = $('<a class="bars" href="#/previews/'+this.model.get('id')+'">'+this.model.get('title')+'</a>')
    this.$el.append(link)
    return this;
  },


  renderBars: function(){
    var bar = new CodePron.Views.IndexItemBar({
      model: this.model
    });
    this.addSubview('#index-bar-'+ this.model.get('id'), bar);
  }

})
