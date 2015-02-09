CodePron.Views.IndexItem = Backbone.CompositeView.extend({
  template: JST['previews/indexItem'],
  className: 'iframe small wrap',

  initialize: function(){
    this.author = CodePron.users.get(this.model.get('author_id'))
  },

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);
    if(this.author){
      var id = this.author.get('id');
      var email = this.author.get('email')
    }else{
      var id = "undefined"
      var email ="undefined"
   }
    var link = $('<a class="bars" href="#/users/'+id+'">'+email+'</a>')
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
