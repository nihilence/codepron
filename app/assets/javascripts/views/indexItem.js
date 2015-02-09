CodePron.Views.IndexItem = Backbone.CompositeView.extend({
  template: JST['previews/indexItem'],
  className: 'iframe small wrap',

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);
    var id = this.model.get('author_id');
    var author = this.model.author().get('email');
    var link = $('<a class="bars" href="#/users/'+id+'">'+author+'</a>')
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
