CodePron.Views.UserShow = Backbone.CompositeView.extend({
  template: JST['users/show'],

  initialize: function(){
    this.listenTo(this.model, "sync", this.render);
  },

  render: function(){
    var content = this.template({user: this.model})
    this.$el.html(content);
    this.renderInfo();
    this.renderIframes()
    return this;
  },

  renderInfo: function(){
    var view = new CodePron.Views.UserInfo({
      model: this.model
    })

    this.addSubview('#info-tab', view)
  },

  renderIframes: function(){
    var view = new CodePron.Views.PreviewsIndex({collection:this.model.previews()})
    this.addSubview("#previews-tab", view);
  },



});
