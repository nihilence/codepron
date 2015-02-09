CodePron.Views.IframeShow = Backbone.View.extend({
  template: JST['previews/iframeShow'],
  className: 'iframe',

  events:{
    "click #comments":"renderComments"
  },

  render: function(){
    var content = this.template({preview: this.model});
    this.$el.html(content);
    return this;
  },

  renderComments: function(){
    $('#comments').addClass("active");
    alert($('#comments'))
  }
})
