CodePron.Views.PreviewsIndex = Backbone.CompositeView.extend({
  template:JST['previews/index'],
  initialize: function(){
    this.listenTo(this.collection, "add", this.addIframe);
    this.listenTo(this.collection, "sync", this.render);
    this.renderIframes();
  },

  events: {
    "click .next-page" : "nextPage",
    "click .prev-page" : "prevPage"
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

  removeIframes: function(){
    var view = this;
    this.subviews('#iframes').forEach(function(subview){
      view.removeSubview('#iframes', subview);
    });

  },

  renderIframes: function(){
    this.collection.each(this.addIframe.bind(this));
  },


  nextPage: function () {
    this.removeIframes();
    this.removeIframes();
    this.removeIframes();
    this.collection.fetch({
      data: { page: this.collection.page_number + 1 },
      remove: true
    })

  },

  prevPage: function(){
    this.removeIframes();
    this.removeIframes();
    this.removeIframes();
    this.collection.fetch({
      data: { page: this.collection.page_number - 1 },
      remove: true
    })

  }


});
