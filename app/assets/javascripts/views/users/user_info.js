CodePron.Views.UserInfo = Backbone.View.extend({
  template:JST['users/info'],

  render: function(){
    var content = this.template({user: this.model})
    this.$el.html(content);
    return this;
  }
})
