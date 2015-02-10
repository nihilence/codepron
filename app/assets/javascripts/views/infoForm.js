CodePron.Views.InfoForm = Backbone.View.extend({
  template: JST['previews/infoForm'],

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);
    return this;
  },

})
