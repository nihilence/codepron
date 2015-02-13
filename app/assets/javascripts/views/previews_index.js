CodePron.Views.PreviewsIndex = Backbone.CompositeView.extend({
  template:JST['previews/index'],
  initialize: function(){
    this.listenTo(this.collection, "add", this.addIframe);
    this.listenTo(this.collection, "sync", this.render);
    this.renderIframes();
  },

  render: function(){
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    if(this.collection.page_number === 1){
      $('.prev-page').remove();
    }
    if(this.collection.page_number === this.collection.total_pages){
      $('.next-page').remove();
    }
    return this;
  },

  addIframe: function(iframe){
    var view = new CodePron.Views.IndexItem({
      model: iframe
    });
    this.addSubview('#iframes', view);
    $('iframe').addClass('small');
  },

  renderIframes: function(){
    this.collection.each(this.addIframe.bind(this));
  },

});
