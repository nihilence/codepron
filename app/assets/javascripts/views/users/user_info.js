CodePron.Views.UserInfo = Backbone.View.extend({
  template:JST['users/info'],

  initialize: function (options){
    this.followers = options.followers;
    this.listenTo(this.model, 'change', this.render);
    this.listenTo(this.model.followers(), 'add', this.render);
  },

  render: function(){
    var content = this.template({user: this.model})
    this.$el.html(content);
    return this;
  }


})
