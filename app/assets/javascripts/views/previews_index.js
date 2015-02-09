CodePron.Views.PreviewsIndex = Backbone.CompositeView.extend({
  template:JST['previews/index'],
  initialize: function(){
    this.listenTo(this.collection, "sync", this.render);

  },

  render: function(){
    var content = this.template();
    this.$el.html(content);
    this.renderIframes();
    return this;
  },

  addIframe: function(iframe){
    var view = new CodePron.Views.IndexItem({
      model: iframe
    });
    this.addSubview('#iframes', view);
    $('.iframe').addClass('small');
  },

  renderIframes: function(){
    this.collection.each(this.addIframe.bind(this));
  }



});
