CodePron.Views.PreviewShow = Backbone.CompositeView.extend({
  template: JST['previews/showPreview'],

  events:{
    "click #comments":"popUp",
    "click #comments.open":"popDown"
  },

  initialize: function(){
    this.collection = this.model.comments();
  },

  render: function(){
    var content = this.template({preview: this.model})
    this.$el.html(content);
    this.renderForm();
    this.renderIframe();
    return this;
  },

  renderForm: function () {
    var view = new CodePron.Views.PreviewForm({
      model: this.model
    });
    this.addSubview('#preview-form', view);
  },

  renderIframe: function(){
    var view = new CodePron.Views.IframeShow({
      model: this.model
    })

    this.addSubview('#preview-iframe', view)
  },

  popUp: function (event){
    event.preventDefault();
    $('.comment-popup').addClass('active');
    $('#comments').addClass('open');
    var view = new CodePron.Views.PreviewComments({model: this.model,
      collection: this.collection})
    this.addSubview('.comment-popup', view)
  },

  popDown: function(event){
    event.preventDefault();
    $('.comment-popup').removeClass('active');
    $('#comments').removeClass('open');
    var that = this;
    this.subviews()['.comment-popup'].forEach(function(view){
      that.removeSubview('.comment-popup', view);

    })
    that.render();
  }


});
